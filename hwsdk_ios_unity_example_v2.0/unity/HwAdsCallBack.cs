using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HwAdsCallBack : MonoBehaviour {

    public void InterCallBack(string msg)
    {
        Debug.Log("receive inter call back msg:" + msg);
        bool bl = false;
        if(msg == "true"){
            bl = true;
        }
        if(HwAdsInterface.interOnCloseEvent != null){
            HwAdsInterface.interOnCloseEvent();
        }
    }

    public void RewardCallBack(string msg)
    {
        Debug.Log("receive reward call back msg:" + msg);
        bool bl = false;
        if(msg == "true"){
            bl = true;
        }
        if(HwAdsInterface.rewardOnCloseEvent != null){
            HwAdsInterface.rewardOnCloseEvent(bl);
        }
    }
}
