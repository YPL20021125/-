import config from '../../utils/config';
Page({
  data: {
    inputVal: "",
    inputShowed: false,
    searchResult: [],
    type:null,
    ss:false
  },
  goToFk(){
    wx.navigateTo({
      url: '/pages/feedback/feedback',
    })
  },
  onLoad(e){
    let type=e.type || '';
    this.setData({
      type
    })
  },
  showInput: function () {
    this.setData({
      inputShowed: true,
    });
  },

  hideInput: function () {
    this.setData({
      inputVal: "",
      inputShowed: false,
      searchResult: [],
    });
  },
  //选择药品
  onCheck(e){
    let index=e.currentTarget.dataset.index;
    wx.setStorageSync('obj', this.data.searchResult[index]);
    wx.navigateBack()
  },
  clearInput: function () {
    this.setData({
      inputVal: "",
    });
  },

  inputTyping: function (e) {
    console.log("Current input:", e.detail.value);
    this.setData({
      inputVal: e.detail.value,
    });
  },

  searchDrugs: function () {
    const keyword = this.data.inputVal.trim();
    console.log("Searching for:", keyword);

    if (!keyword) {
        wx.showToast({
            title: "请输入搜索关键词",
            icon: "none",
        });
        return;
    }
    const that = this;
    that.setData({
      ss:true
    })
    wx.request({
        url: config.host+"/api/search/drugs",
        data: { keyword: keyword },
        success: function (res) {
            console.log("Search results:", res.data);
                that.setData({
                    searchResult: res.data.drugs,
                });

        },
        fail: function () {
            wx.showToast({
                title: "网络错误",
                icon: "none",
            });
        },
    });
}

});
