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
        string serverUrl = "http://console.gamebrain.io/advertise/advlist?appid=127";
#if UNITY_EDITOR

#else
        HwAdsInterface.InitSdk(serverUrl);
#endif
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public void InterShow() {
        Debug.Log("inter show click");
        HwAdsInterface.unityShowInterAd();
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
