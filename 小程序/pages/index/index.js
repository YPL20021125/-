// index.js
import config from '../../utils/config';
import util from '../../utils/util';
Page({
  data: {
    medications: [],
    showModal: false,
    richTextDetails: "",
    isEditing: false,
    drugInfos: [],
    currentMedication: {},
    times:[],
    date:'',
    // 其他数据...
    frequencyOptions: [],
    currentFrequencyIndex: 0
  },
  //前往选择药品
  gotoSearch(){
    wx.navigateTo({
      url: '/pages/drugsearch/drugsearch?type=1',
    })
  },
  //选择用药时间
  onChangeTime(e){
    let ind=parseInt(e.detail.value);
    let index=e.currentTarget.dataset.index;
    this.setData({
      [`currentMedication.next_dose_time[${index}]`]:this.data.times[ind]
    })
  },
  onShow: function (e) {
    const app = getApp();
    if (!app.globalData.isUserLoggedIn) {
      // 用户未登录，显示模态对话框提示登录
      wx.showModal({
        title: "提示",
        content: "您尚未登录，请登录后使用完整功能",
        showCancel: false,
        confirmText: "去登录",
        success: (result) => {
          if (result.confirm) {
            // 用户点击去登录，跳转到我的页面
            wx.switchTab({
              url: "/pages/profile/profile", // 确保你的“我的”页面路由正确
            });
          }
        },
      });
    } else {
      // 已登录状态下执行的代码
      this.initFrequencyOptions();
      this.loadMedications();
      this.loadDrugInfos();
      this.setData({
        times:app.globalData.userInfo.times,
      })
    }
    let obj=wx.getStorageSync('obj')|| '';
    if (obj) {
      let dose_times=[];
      for (let index = 0; index < obj.frequency_per_day; index++) {
        dose_times.push('')  
      }
      this.setData({
        ['currentMedication.name']:obj.name,
        ['currentMedication.frequency']:parseInt(obj.frequency_per_day),
        dose_times
      })
    }
  },
  initFrequencyOptions: function() {
    const app = getApp();  // 获取全局应用实例
    const timesLength = app.globalData.userInfo.times.length;
    let frequencyOptions = [];
    for (let i = 1; i <= timesLength; i++) {
      frequencyOptions.push(i.toString());
    }
    this.setData({
      frequencyOptions: frequencyOptions
    });
  },
  
  onFrequencyChange: function(e) {
    const index = parseInt(e.detail.value);
    this.setData({
      currentFrequencyIndex: index,
      'currentMedication.frequency': parseInt(this.data.frequencyOptions[index])
    });
  },
  onXxCz(e){
    let type=e.currentTarget.dataset.type;
    if (type=='1') {
        let date=this.data.date;
        if (!date) {
            wx.showToast({
              title: '日期为空',
              icon:"none"
            })
            return false;
        }
        wx.showLoading({
          title: '查询中...',
        })
        const app = getApp();
        const userInfo = app.globalData.userInfo;
        wx.request({
          url: config.host+'/api/medications/date',
          data:{
            date,
            phone:userInfo.phone
          },
          success:(res)=>{
            wx.hideLoading();
            this.setData({ medications: res.data.medications });
          },
          fail:()=>{
            wx.showToast({
              title: '查询失败',
              icon:"none"
            })
            
          }
        })
    }else{
      wx.showToast({
        title: '已重置',
      })
      this.loadMedications();
    this.loadDrugInfos();
      this.setData({
        date:''
      });
    }
  },
  onLoad: function () {
    this.loadMedications();
    this.loadDrugInfos();
    this.initFrequencyOptions();
  },

  startEditing: function () {
    this.setData({ isEditing: true });
  },

  inputChange: function (e) {
    const param = e.currentTarget.dataset.param;
    let value = e.detail.value; // 获取输入值，对于日期来说，应直接使用，无需进一步格式化
    if (param=='frequency') {
      value=parseInt(value);
      this.setData({
        ['currentMedication.next_dose_time']:[]
      })
    }
    this.setData({
      [`currentMedication.${param}`]: value,
    });
  },
  onXxDateChange: function (e) {
    let  date=e.detail.value;
    this.setData({
       date,
    });
  },
  onDateChange: function (e) {
    const param = e.currentTarget.dataset.param;
    let  start_date=e.detail.value;
    if (param=='start_date') {
        let date=new Date(util.formatTime(new Date)).getTime();
        let startTime=new Date(start_date).getTime();
        if (startTime<date) {
            wx.showToast({
              title: '不能比当前日期小',
              icon:"none"
            })
            return false;
        }
    }
    this.setData({
      [`currentMedication.${param}`]: start_date,
    });
  },

  showCreateForm: function () {
    if (this.data.drugInfos.length === 0) {
      this.loadDrugInfos();  // 如果药品信息为空，重新加载
    }
    // 设置默认值或空值以供新建药单使用
    this.setData({
      currentMedication: {
        id: "",
        name: "",
        dosage: "",
        frequency: "",
        start_date: "",
        end_date: "",
        notes: "",
        next_dose_time:[],
        drug_id: null  // 添加 drug_id 以存储选择的药品 ID
      },
      showModal: true,
      isEditing: true  // 直接进入编辑模式
    });
  },

  onDrugChange: function(e) {
    const index = e.detail.value;
    const drug = this.data.drugInfos[index];
  
    // 如果是 undefined，则赋值为空字符串
    const dosage = drug.defaultDosage || '';
    const frequency = drug.defaultFrequency || '';
  
    this.setData({
      'currentMedication.name': drug.name,
      'currentMedication.dosage': dosage,
      'currentMedication.frequency': frequency,
      'currentMedication.drug_id': drug.id
    });
  },
  
  deleteMedication: function () {
    const medicationId = this.data.currentMedication.id;
    // 弹出确认对话框
    wx.showModal({
      title: '确认删除',
      content: '您确定要删除这个药单吗？此操作无法撤销。',
      success: (res) => {
        if (res.confirm) {
          // 用户点击确定
          wx.request({
            url: `${config.host}/api/medications/${medicationId}`,
            method: "DELETE",
            success: (res) => {
              if (res.data.success) {
                wx.showToast({ title: "药单已删除", icon: "success" });
                this.closeDetails();
                this.loadMedications(); // 重新加载以反映删除
              } else {
                wx.showToast({ title: res.data.message, icon: "none" });
              }
            },
            fail: () => {
              wx.showToast({ title: "请求失败", icon: "none" });
            }
          });
        } else if (res.cancel) {
          // 用户点击取消
          wx.showToast({ title: '取消删除', icon: 'none' });
        }
      }
    });
  },  

  saveChanges: function () {
    const app = getApp();  // 获取全局应用实例
    const userPhone = app.globalData.userInfo.phone;
    const medicationData = this.data.currentMedication;
    if (!medicationData.name) {
      wx.showToast({
        title: '请选择药品',
        icon:"none"
      })
      return false;
    }
    let flag=true;
    let timeSet = new Set();  // 使用Set集合来检查时间的唯一性
    if (medicationData.next_dose_time.length != this.data.currentMedication.frequency){
      wx.showToast({
        title: `时间段不能为空`,
        icon: "none"
      })
      flag = false;
    }
    for (let index = 0; index < medicationData.next_dose_time.length; index++) {
      const item = medicationData.next_dose_time[index];
      if (timeSet.has(item)) {
        wx.showToast({
          title: `第${index+1}次时间与其他时间重复`,
          icon: "none"
        })
        flag = false;
        break;  // 发现重复时间立即终止循环
      }
      timeSet.add(item);  // 将时间添加到集合中
    }

    if (flag) {
      medicationData.next_dose_time=JSON.stringify(medicationData.next_dose_time)
    // 在发送数据之前添加电话号码
    const postData = {
      ...medicationData,
      phone: userPhone  // 动态添加电话号码
    };

    const url = this.data.currentMedication.id
      ? `${config.host}/api/medications/${this.data.currentMedication.id}` // 如果有 id 则更新
      : `${config.host}/api/medications`; // 没有 id 则创建新的药单

    wx.request({
      url: url,
      method: this.data.currentMedication.id ? "PUT" : "POST",
      data: postData,
      success: (res) => {
        if (res.data.success) {
          wx.showToast({ title: "操作成功", icon: "success" });
          this.closeDetails();
          this.loadMedications(); // 重新加载药单列表以显示最新的数据
        } else {
          wx.showToast({ title: res.data.message, icon: "none" });
        }
      },
      fail: () => {
        wx.showToast({ title: "请求失败", icon: "none" });
      },
    });
    }
    
  },

  loadMedications: function () {
    const app = getApp();
    const userInfo = app.globalData.userInfo;
    wx.request({
      url: config.host+"/api/medications",
      method: "GET",
      data: { phone: userInfo.phone },
      success: (res) => {
        if (res.data.success) {
          this.setData({ medications: res.data.medications });
        } else {
          wx.showToast({
            title: "加载失败",
            icon: "none",
          });
        }
      },
    });
  },

  loadDrugInfos: function () {
    wx.request({
      url: config.host+'/api/drug-info',
      method: 'GET',
      success: (res) => {
        if (res.data.success) {
          this.setData({ drugInfos: res.data.drugInfos });
        } else {
          wx.showToast({ title: '加载药品信息失败', icon: 'none' });
        }
      },
      fail: () => {
        wx.showToast({ title: '请求药品信息失败', icon: 'none' });
      }
    });
  },

  formatDate: function (dateStr) {
    // 确保输入的日期字符串是有效的
    if (!dateStr) return "无"; // 处理空值
    let date = new Date(dateStr);
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    return `${year}-${month.toString().padStart(2, "0")}-${day
      .toString()
      .padStart(2, "0")}`;
  },

  showDetails: function (e) {
    const item = e.currentTarget.dataset.item;
    item.frequency=parseInt(item.frequency);
    item.next_dose_time=JSON.parse(item.next_dose_time);
    const formattedItem = {
      ...item,
      start_date: this.formatDate(item.start_date), // 确保日期格式化
      end_date: this.formatDate(item.end_date), // 确保日期格式化
    };
    let str='';
    for (let index = 0; index < item.next_dose_time.length; index++) {
      const ite= item.next_dose_time[index];
      str+=`第${index+1}次服药时间:${ite}<br/>`;
    }

    const details = `剂量: ${item.dosage}<br/>
                    频率: ${item.frequency}<br/>
                    ${str}
                    开始日期: ${this.formatDate(item.start_date)}<br/>
                    结束日期: ${this.formatDate(item.end_date)}<br/>
                    库存剂量: ${item.taken_today || '无'}<br/>
                    备注: ${item.notes || '无'}`;

    this.setData({
      currentMedication: formattedItem, // 使用已格式化的日期数据
      currentMedicationName: item.name,
      richTextDetails: details,
      showModal: true,
      isEditing: false,
    });
  },

  closeDetails: function () {
    this.setData({
      showModal: false,
      isEditing: false,
      currentMedication: {},
    });
  },
});
