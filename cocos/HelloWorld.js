cc.Class({
    extends: cc.Component,

    properties: {
        videoButton: {
            default: null,
            type: cc.Button
        },
        videoTip: {
            default: null,
            type: cc.Label
        },

        interButton: {
            default: null,
            type: cc.Button
        },
        interTip: {
            default: null,
            type: cc.Label
        },

        showBannerButton: {
            default: null,
            type: cc.Button
        },
        hideBannerButton: {
            default: null,
            type: cc.Button
        },
        bannerTip: {
            default: null,
            type: cc.Label
        },
    },

    // use this for initialization
    onLoad: function() {
        this.videoButton.node.on("click", this.videoButtonClick, this);
        this.interButton.node.on("click", this.interButtonClick, this);
        this.showBannerButton.node.on("click", this.showBannerButtonClick, this);
        this.hideBannerButton.node.on("click", this.hideBannerButtonClick, this);
        this.initSDK();
    },

    videoButtonClick: function() {
        this.videoTip.string = "Video Ad Status:loading";
        console.log("videoButtonClick");
        if (this.isVideoAdLoaded()) {
            console.log("video ad show");
            this.showVideoAd();
        } else {
            console.log("video ad not loaded");
        }
    },

    interButtonClick: function() {
        this.interTip.string = "Inter Ad Status:loading";
        console.log("interButtonClick");
        if (this.isInterAdLoaded()) {
            console.log("inter ad show");
            this.showInterAd();
        } else {
            console.log("inter ad not loaded");
        }
    },

    showBannerButtonClick: function() {
        this.bannerTip.string = "Banner Ad Status:loading";
        console.log("showBannerButtonClick");
        if (this.isBannerAdLoaded()) {
            console.log("banner ad show");
            this.showBannerAd();
        } else {
            console.log("banner ad not loaded");
        }
    },

    hideBannerButtonClick: function() {
        this.bannerTip.string = "Banner Ad Status:loading";
        console.log("hideBannerButtonClick");
        if (this.isBannerAdLoaded()) {
            console.log("banner ad hide");
            this.hideBannerAd();
        } else {
            console.log("banner ad not loaded");
        }
    },

    initSDK: function() {
        console.log("call HwAdsCocos initSDK:201");
        jsb.reflection.callStaticMethod("HwAdsCocos",
            "initSDK:",
            "201");
    },

    isVideoAdLoaded: function() {
        console.log("call HwAdsCocos isVideoAdLoaded");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "isVideoAdLoaded");
    },

    showVideoAd: function() {
        console.log("call HwAdsCocos showVideoAd");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "showVideoAd");
    },

    isInterAdLoaded: function() {
        console.log("call HwAdsCocos isInterAdLoaded");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "isInterAdLoaded");
    },

    showInterAd: function() {
        console.log("call HwAdsCocos showInterAd");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "showInterAd");
    },

    isBannerAdLoaded: function() {
        console.log("call HwAdsCocos isBannerAdLoaded");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "isBannerAdLoaded");
    },

    showBannerAd: function() {
        console.log("call HwAdsCocos showBannerAd");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "showBannerAd");
    },

    hideBannerAd: function() {
        console.log("call HwAdsCocos hideBannerAd");
        return jsb.reflection.callStaticMethod("HwAdsCocos", "hideBannerAd");
    }
});