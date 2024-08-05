// pages/login/login.js
const app = getApp();  // 获取App实例

import config from '../../utils/config';

let ePat = /^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\d{8}$/;

Page({
  data: {
    phone: '',
    password: '',
    flag:false
  },
  inputPhone: function(e) {
    this.setData({ phone: e.detail.value });
  },

  inputPassword: function(e) {
    this.setData({ password: e.detail.value });
  },

  manualLogin: function() {
    let phone=this.data.phone;
    let password=this.data.password;
    if (!ePat.test(phone)) {
        wx.showToast({
          title: '手机号格式不正确或为空',
          icon:"none"
        })
        return false;
    }
    if (!password) {
      wx.showToast({
        title: '密码不能为空',
        icon:"none"
      })
      return false;
  }
    wx.request({
      url: config.host+'/api/login',
      method: 'POST',
      data: { phone, password },
      success: (res) => {
        console.log(res);
        if (res.data.success) {
          // 更新全局状态
          app.globalData.userInfo = res.data.user;
          app.globalData.isUserLoggedIn = true;

          // 登录成功，存储用户信息
          wx.setStorageSync('userInfo', res.data.user);

          wx.showToast({
            title: '登录成功',
            icon: 'success',
            complete: () => {
              wx.switchTab({
                url: '/pages/index/index'
              });
            }
          });
        } else {
          wx.showToast({ title: res.data.message || '登录失败', icon: 'none' });
          this.setData({
            flag:true
          })
        }
      },
      fail: () => {
        wx.showToast({ title: '网络请求失败', icon: 'none' });
      }
    });
  }
});
