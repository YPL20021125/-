// pages/feedback/feedback.js
import util from '../../utils/util';
import config from '../../utils/config'
Page({

  /**
   * 页面的初始数据
   */
  data: {
    title: '',
    content: ''
  },
  //获取数据
  getVal(e) {
    var val = e.detail.value;
    var typ = e.currentTarget.dataset.typ;
    this.setData({
      [`${typ}`]: val
    })
  },
  deteIs(i){
    if (i<10) {
      return "0"+i
    }else{
      return i
    }
  },
  //提交
  subFk() {
    var title = this.data.title;
    var content = this.data.content;
    const app=getApp();
    let user=app.globalData.userInfo;
    let isUserLoggedIn=app.globalData.isUserLoggedIn;
    
    if (!title) {
      wx.showToast({
        title: '标题不能为空',
        icon: "none"
      })
      return false
    }
    if (!content) {
      wx.showToast({
        title: '内容不能为空',
        icon: "none"
      })
      return false
    }
    if (!isUserLoggedIn) {
        wx.showToast({
          title: '请先进行登录!',
          icon:"none"
        })
        return false;
    }

    wx.showModal({
      title: '提示',
      content: '是否确定提交',
      complete: (res) => {
        if (res.cancel) {
          wx.showToast({
            title: '已取消',
            icon: "none"
          })
        }
        if (res.confirm) {
          var date = new Date()
          var year = date.getFullYear()
          var month = this.deteIs(date.getMonth() + 1)
          var day = this.deteIs(date.getDate())
          var dat = year + '-' + month + '-' + day;
          var hours = this.deteIs(date.getHours()); //获取当前小时
          var minutes = this.deteIs(date.getMinutes()); //获取当前分钟
          var seconds = this.deteIs(date.getSeconds())
          let dateTime =dat+' '+hours+':'+minutes+':'+seconds
            wx.showLoading({
              title: '提交中...',
            })
          setTimeout(() => {
            wx.request({
              url: `${config.host}/api/add/feedbacks`,
              method: 'POST',
              data: {
                title,
                content,
                dateTime,
                name:user.name,
                phone:user.phone
              },
              success:(res)=>{
                 wx.showToast({
                   title: '提交成功',
                 })
                 setTimeout(()=>{
                  wx.navigateBack();
                 },500)
              }
            })
          }, 800)
        }
      }
    })
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad(options) {
    
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload() {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage() {

  }
})