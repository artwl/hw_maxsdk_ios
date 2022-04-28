
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

//1.在canvas上挂载这个节点，自动初始化，自动加载广告，
//2.游戏端仅仅需要调用显示插屏，显示激励就好
//3.回调按约定好的名字，传输
public class AdMgr : MonoBehaviour {


	// Use this for initialization
	void Start () {
        int serverUrl = 127;
// #if UNITY_EDITOR

// #else
        HwAdsInterface.InitSdk(serverUrl);
// #endif
	}
	
	// Update is called once per frame
	void Update () {
		
	}

   //关于banner//关于inter
//关于reward
//关于内购打点
//关于sdk版本号
//关于上传sdk日志
//自己根据需要选择调用不同的方法--HwAdsInterface类中
public void BannerShow(){
    HwAdsInterface.unityShowBannerAd();

}
public void BannerHide(){
    HwAdsInterface.unityHideBannerAd();
}

public bool isShowBanner(){
    return HwAdsInterface.unityIsBannerLoaded();
}
   

    Action<bool> rewardAction;
    public void RewardShow() {
        Debug.Log("reward show click");
        rewardAction = ActionReward;
        HwAdsInterface.unityShowRewardAd("test",rewardAction);
    }

    public void ActionReward(bool result)
    {
        Debug.Log("action reward result :" + result);
    }
   

}