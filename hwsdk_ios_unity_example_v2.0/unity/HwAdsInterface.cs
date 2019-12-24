using UnityEngine;
using System;
using System.Runtime.InteropServices;
using HwAds;

public class HwAdsInterface
{
    [DllImport("__Internal")]
    private static extern void initHwSDK(string serverURL);
    [DllImport("__Internal")]
    private static extern void loadHwInterAd();
    [DllImport("__Internal")]
    private static extern void showHwInterAd();
    [DllImport("__Internal")]
    private static extern bool isHwInterAdLoaded();
    [DllImport("__Internal")]
    private static extern void loadHwRewardAd();
    [DllImport("__Internal")]
    private static extern void showHwRewardAd(string rewardTag);
    [DllImport("__Internal")]
    private static extern bool isHwRewardAdLoaded();

    //插屏回调
    public static Action interOnCloseEvent;
    //激励回调
    public static Action<bool> rewardOnCloseEvent;
    public static bool isDebug { get; private set; }


    public static void InitSdk(string serverURL)
    {
        GameObject hwAdsCallBack = new GameObject("HwAdsCallBack");
        GameObject.DontDestroyOnLoad(hwAdsCallBack);
        hwAdsCallBack.AddComponent<HwAdsCallBack>();
        Debug.Log("unity InitSdk");
        initHwSDK(serverURL);

    }

    public static void unityLoadInterAd() {
        loadHwInterAd();
    }

    public static void unityShowInterAd()
    {
        unityShowInterAd(null);
    }

    public static void unityShowInterAd(Action interCallBack) {
        if (unityIsInterLoaded())
        {
            Debug.Log("inter is loaded show");
            interOnCloseEvent = interCallBack;
            showHwInterAd();
        }
        else {
            Debug.Log("inter not loaded");
        }
        
    }



    public static bool unityIsInterLoaded() {
        return isHwInterAdLoaded();
    }

    public static void unityLoadRewardAd() {
        loadHwRewardAd();
    }

    /// <summary>
    /// unity调用显示广告的方法
    /// </summary>
    /// <param name="adTag">广告便签，如：双倍奖励，就传"double"</param>
    public static void unityShowRewardAd(string adTag, Action<bool> rewardCallBack) {
        if (unityIsRewardLoaded())
        {
            Debug.Log("reward is loaded");
            rewardOnCloseEvent = rewardCallBack;
            showHwRewardAd(adTag);
        }
        else {
            Debug.Log("reward not loaded");
        }        
    }

    public static bool unityIsRewardLoaded() {
        return isHwRewardAdLoaded();
    }
}
