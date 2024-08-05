// pages/myprofile/myprofile.js
const app = getApp();
import config from '../../utils/config';
Page({
  data: {
    userInfo: {},
    num:0
  },

  onShow: function () {
    this.setData({
      userInfo: app.globalData.userInfo,
      num:app.globalData.userInfo.times.length
    });
  },
  onInputNum(e){
    let num=parseInt(e.detail.value); 
    if(0<=num<1000){
      let times=[];
      for (let index = 0; index < num; index++) {
        times.push('');
      }
      this.setData({
        num,
        ['userInfo.times']:times
      });
    }
    else{
      wx.showToast({
        title: '时间段数量过大',
        icon: 'none'
      });
    }
    


  },
  onInput: function (e) {
    const field = e.currentTarget.dataset.field;
    this.setData({
      [`userInfo.${field}`]: e.detail.value
    });
  },

  onTimeChange: function(e) {
    const index = e.currentTarget.dataset.index; // 获取当前picker的索引
    const newTime = e.detail.value; // 用户选择的新时间
    const currentTimes = [...this.data.userInfo.times]; // 当前所有时间的快照
  
    // 创建一个 Set 从现有时间，除去当前index的时间
    let timeSet = new Set(currentTimes.filter((_, i) => i !== index));
  
    // 检查新选择的时间是否已被选
    if (timeSet.has(newTime)) {
      wx.showToast({
        title: '时间段不能重复',
        icon: "none"
      });
      return; // 如果新时间已存在，则提醒用户并终止更新
    }
  
    // 更新时间在当前位置
    currentTimes[index] = newTime;
    this.setData({
      [`userInfo.times`]: currentTimes // 更新全体时间数组
    });
  },
  
  updateUserInfo() {
    const app = getApp();
    let userInfo=this.data.userInfo;
    // 检查每个时间段是否已设置
    let allTimesSet = true;
    for (let i = 0; i < userInfo.times.length; i++) {
      console.log(userInfo.times[i]);
      if (userInfo.times[i] === "") {
        allTimesSet = false;
        wx.showToast({
          title: '所有时间段必须设置',
          icon: 'none'
        });
        break; // 如果发现未设置的时间段，立即终止检查
      }
    }

    if (!allTimesSet) {
      return; // 如果有未设置的时间段，则终止保存
    }
    
    userInfo.times=JSON.stringify(userInfo.times);

    // 发送请求到服务器更新用户信息
    wx.request({
      url: config.host+'/api/updateUserInfo',
      method: 'POST',
      data: userInfo,
      success: (res) => {
        console.log(res);
        if (res.data.success) {
          wx.showToast({
            title: '信息更新成功',
            icon: 'success'
          });
          // 更新全局userInfo
          userInfo.times=JSON.parse(userInfo.times);
          app.globalData.userInfo = userInfo;
          // 本地存储同步更新
          wx.setStorageSync('userInfo', userInfo);
        } else {
          wx.showToast({
            title: '更新失败',
            icon: 'none'
          });
        }
      }
    });
  },
  updateUserInfo() {
    let userInfo=this.data.userInfo;
    userInfo.times=JSON.stringify(userInfo.times);
    // 发送请求到服务器更新用户信息
    wx.request({
      url: config.host+'/api/updateUserInfo',
      method: 'POST',
      data: userInfo,
      success: (res) => {
        console.log(res);
        if (res.data.success) {
          wx.showToast({
            title: '信息更新成功',
            icon: 'success'
          });
          // 更新全局userInfo
          userInfo.times=JSON.parse(userInfo.times);
          app.globalData.userInfo = userInfo;
          // 本地存储同步更新
          wx.setStorageSync('userInfo', userInfo);
        } else {
          wx.showToast({
            title: '更新失败',
            icon: 'none'
          });
        }
      }
    });
  },

  resetPassword: function () {
    // 跳转到重置密码页面
    wx.navigateTo({
      url: '/pages/resetPassword/resetPassword'
    });
  }
});