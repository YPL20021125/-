// app.js
App({
  globalData: {
    userInfo: null,
    isUserLoggedIn: false
  },

  onLaunch() {
    // 处理登录状态
    const userInfo = wx.getStorageSync('userInfo');
    if (userInfo) {
      this.globalData.isUserLoggedIn = true;
      this.globalData.userInfo = userInfo;
    }
  }
})