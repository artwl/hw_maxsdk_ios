using UnityEngine;
using System;
using System.Runtime.InteropServices;

// using HwAds;

public class HwAdsInterface
{
    [DllImport("__Internal")]
    private static extern void initHwSDK(int serverURL);
//关于banner
    [DllImport("__Internal")]
private static extern void showHwBannerAd();
[DllImport("__Internal")]
private static extern void hideHwBannerAd();
 [DllImport("__Internal")]
    private static extern bool isHwBannerAdLoaded();

    //关于inter
    [DllImport("__Internal")]
    private static extern void showHwInterAd();
    [DllImport("__Internal")]
    private static extern bool isHwInterAdLoaded();
    //关于reward
    [DllImport("__Internal")]
    private static extern void showHwRewardAd(string rewardTag);
    [DllImport("__Internal")]
    private static extern bool isHwRewardAdLoaded();

    //关于内购打点
 [DllImport("__Internal")]
    private static extern void hwAnalyticsPurchase(string dollers,string productId,int purchaseType,string orderId,string purchaseToken);
    //关于SDK版本号
 [DllImport("__Internal")]
 private static extern string hwSdkVersion();
 //关于上传日志
  [DllImport("__Internal")]
  private static extern void reportLogByID(int serverURL);




    //插屏回调
    public static Action interOnCloseEvent;
    //激励回调
    public static Action<bool> rewardOnCloseEvent;
    // public static bool isDebug { get; private set; }

//初始化
    public static void InitSdk(int serverURL)
    {
        GameObject hwAdsCallBack = new GameObject("HwAdsCallBack");
        GameObject.DontDestroyOnLoad(hwAdsCallBack);
        hwAdsCallBack.AddComponent<HwAdsCallBack>();
        Debug.Log("unity InitSdk");
        initHwSDK(serverURL);

    }

//关于banner
public static void unityShowBannerAd(){
showHwBannerAd();

}
public static void unityHideBannerAd(){
    hideHwBannerAd();
}
public static bool unityIsBannerLoaded() {
        return isHwBannerAdLoaded();
    }

//关于inter

    public static void unityShowInterAd(Action interCallBack)
    {
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

//关于reward

public static void unityShowRewardAd(string tag,Action<bool> rewardCallBack){

if (unityIsRewardAdLoaded())
        {
            Debug.Log("reward is loaded");
            rewardOnCloseEvent = rewardCallBack;
            showHwRewardAd(tag);
        }
        else {
            Debug.Log("reward not loaded");
        }   
}

public static bool unityIsRewardAdLoaded(){
    return isHwRewardAdLoaded();
}

//关于内购打点的方法调用
public static void unityAnalyticsPurchase(string dollers,string currency,string productId,int purchaseType,string orderId,string purchaseToken ){

hwAnalyticsPurchase(dollers,currency,productId,purchaseType,orderId,purchaseToken);
}

//sdk版本号
public static string unitySdkVersion(){
   return hwSdkVersion();
}
public static void unityReportLogById(int serverURL){
    reportLogByID(serverURL);
    
}


}
