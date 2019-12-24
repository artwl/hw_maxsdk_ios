//
//  HwAdsInterface.m
//  Unity-iPhone
//
//  Created by game team on 2019/11/15.
//

#import <Foundation/Foundation.h>

#import <HwAdsFramework/HwAdsFramework.h>
#import <HwAdsFramework/HwAds.h>

#import "HwAdsInterface.h"

@implementation HwAdsInterface

static HwAdsInterface *hwAdsInterfaceInstance;

+ (id) sharedInstance{
    if(hwAdsInterfaceInstance == nil){
        NSLog(@"shareInstance");
        hwAdsInterfaceInstance = [[self alloc] init];
    }
    return hwAdsInterfaceInstance;
}

#pragma mark HwAdsDelegate
- (void) hwAdsRewardedVideoLoadSuccess{
    NSLog(@"call hwAdsRewardedVideoLoadSuccess");
}

- (void) hwAdsRewardedVideoGiveReward{
    NSLog(@"call hwAdsRewardedVideoGiveReward");
}

- (void) hwAdsRewardedVideoClose{
    NSLog(@"call hwAdsRewardedVideoClose");
}

- (void) hwAdsRewardedVideoClick{
    NSLog(@"call hwAdsRewardedVideoClick");
}

- (void) hwAdsRewardedVideoLoadFail{
    NSLog(@"call hwAdsRewardedVideoLoadFail");
}

- (void)hwAdsRewardedVideoDidAppear {
    NSLog(@"call hwAdsRewardedVideoDidAppear");
}


- (void)hwAdsRewardedVideoLoadExpire {
    NSLog(@"call hwAdsRewardedVideoLoadExpire");
}


- (void)hwAdsRewardedVideoPlayFail {
    NSLog(@"call hwAdsRewardedVideoPlayFail");
}

@end


void initHwSDK(char * serverURL){
    NSLog(@"initHwSDK");
    HwAdsInterface* hwAdsInterface = [HwAdsInterface sharedInstance];
    
    [[HwAds instance] initSDK:[NSString stringWithUTF8String:serverURL]];
    HwAds* hwads = [HwAds instance];
    hwads.hwAdsDelegate = hwAdsInterface;
}

void loadHwInterAd(){
    NSLog(@"call loadInterAd");
    [[HwAds instance] loadInter];
}

void showHwInterAd(){
    NSLog(@"call ShowInterAd");
    [[HwAds instance] showInter];
}

BOOL isHwInterAdLoaded(){
    NSLog(@"call isInterLoaded");
    return [[HwAds instance] isInterLoad];
}

void loadHwRewardAd(){
    NSLog(@"call loadRewardedVideo");
    [[HwAds instance] loadReward];
}

void showHwRewardAd(char * tag){
    NSLog(@"call showRewardedVideo");
    [[HwAds instance] showReward:[NSString stringWithUTF8String:tag]];
}

BOOL isHwRewardAdLoaded(){
    NSLog(@"call isRewardLoaded");
    return [[HwAds instance] isReward];
}

void hwFbEvent(char * category, char * action, char * label){
    NSLog(@"call hwFbEvent");
    [[HwAds instance] hwFbEvent:[NSString stringWithUTF8String:category] action:[NSString stringWithUTF8String:action]label:[NSString stringWithUTF8String:label]];
}
