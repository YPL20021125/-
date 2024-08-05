const app=getApp();
import config from '../../utils/config';
import util from '../../utils/util';
Page({
  data: {
    userMealTimes: {},
    todayMedications: [], // 存储今天需要服用的药物
    showModal: false,
    currentMedication: {},
    currentMedicationName: '',
    richTextDetails: '',
    dateString: "",
    spot:[],
    times:[],
    date:''
  },
  checkboxChange(e){
    let list=e.detail.value;
    let id=e.currentTarget.dataset.id;
    let dosage=e.currentTarget.dataset.dosage;
    let type=0;
    if (list.length>0) {
      type=2;
    }else{
      type=1;
    }
    wx.request({
      url: config.host+'/api/meAbs/'+id,
      method:'PUT',
      data:{
        dosage,
        type
      },
      success:(res)=>{
        this.loadTodayMedications();
      }
    })
  },
  dateChange(e) {
    this.setData({
      dateString: e.detail.dateString,
      todayMedications:[]
    })
    this.loadTodayMedications();
  },
  onShow: function () {
    this.setData({
      date:util.formatTime(new Date())
    })
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
      this.setData({
        times:app.globalData.userInfo.times
      })
      this.loadTodayMedications();
    }
  },

  onLoad: function() {
  
  },

  // 获取今日需要服用的药物
  loadTodayMedications: function() {
    const app = getApp();  // 获取全局应用实例
    const userPhone = app.globalData.userInfo.phone;
    const date=this.data.dateString;
    return new Promise((resolve, reject) => {
      wx.request({
        url: config.host+'/api/medications/today',
        method: 'GET',
        data: {phone :userPhone,date},
        success: (res) => {
          console.log("Loaded medications:", res.data.medications); // 打印获取的药物数据
          app.globalData.todayMedications = res.data.medications; // 保存到全局变量
          this.setData({ todayMedications: res.data.medications }); // 更新页面数据
          if (res.data.success) {
            resolve(res.data.medications);
          } else {
            reject('无法加载今日药物: ' + res.data.message);
          }
        },
        fail: () => {
          reject("请求失败");
        }
      });
    });
  },

  // 显示药物用量和备注
  showDetails: function(e) {
    const app = getApp();
    const medicationId = parseInt(e.currentTarget.dataset.id); // 获取绑定的药品 ID，确保转为整数类型
    const item = app.globalData.todayMedications.find(med => med.id === medicationId); // 根据 ID 查找匹配的药品对象
  
    if (!item) {
      wx.showToast({
        title: '未找到药品信息',
        icon: 'none'
      });
      return;
    }
  
    const details = `剂量: ${item.dosage}<br/>备注: ${item.notes || '无'}`;
  
    this.setData({
      currentMedication: item,
      currentMedicationName: item.name,
      richTextDetails: details,
      showModal: true, // 显示模态框
    });
  },

  closeDetails: function () {
    this.setData({
      showModal: false
    });
  }

});
