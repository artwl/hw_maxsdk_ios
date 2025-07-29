//
//  HwAdsInterface.m
//  Unity-iPhone
//
//  Created by game team on 2020/05/10. V5.0
//

#import <Foundation/Foundation.h>

#import <HwAdsFramework/HwAds.h>
//#import "HwAds.h"
//#import <GameAnalytics/GameAnalytics.h>

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
//广告加载成功，收到这个回调
- (void) hwAdsRewardedVideoLoadSuccess{
    NSLog(@"call hwAdsRewardedVideoLoadSuccess");
}

//广告调用了show方法，收到这个回调
- (void)hwAdsRewardedVideoWillAppear {
    NSLog(@"call hwAdsRewardedVideoWillAppear");
}

//广告显示，调用这个回调
- (void)hwAdsRewardedVideoDidAppear {
    NSLog(@"call hwAdsRewardedVideoDidAppear");
}

//广告播放完成，给用户奖励
- (void) hwAdsRewardedVideoGiveReward{
    NSLog(@"call hwAdsRewardedVideoGiveReward");
}

//广告关闭
- (void) hwAdsRewardedVideoClose{
    NSLog(@"call hwAdsRewardedVideoClose  hide banner right now");
}

//广告点击回调
- (void) hwAdsRewardedVideoClick{
    NSLog(@"call hwAdsRewardedVideoClick");
}

//广告加载失败
- (void) hwAdsRewardedVideoLoadFail{
    NSLog(@"call hwAdsRewardedVideoLoadFail");
}

//广告播放失败，不给用户奖励
- (void)hwAdsRewardedVideoPlayFail {
    NSLog(@"call hwAdsRewardedVideoPlayFail");
}

#pragma HWAdsInterDelegate
//插屏播放
- (void)hwAdsInterstitialShow{
    NSLog(@"hwAdsInterstitialShow");
}
//插屏关闭
- (void)hwAdsInterstitialClose{
    NSLog(@"hwAdsInterstitialClose");
}

//add
- (void)hwAdsInterstitialLoadSuccess{
    NSLog(@"hwAdsInterstitialLoadSuccess");
}
- (void)hwAdsInterstitialLoadFail{
    NSLog(@"hwAdsInterstitialLoadFail");
}
- (void)hwAdsInterstitialClick{
    NSLog(@"hwAdsInterstitialClick");
}

#pragma HwAdsBannerDelegate
- (void)hwAdsBannerLoadSuccess{
    NSLog(@"call hwAdsBannerLoadSuccess");
}
@end

void getCountryCode(){
    NSString *deviceName = [[UIDevice currentDevice] name];
    NSString *deviceCountryCode = [[UIDevice currentDevice] systemVersion];
    
    NSString *lanarr = NSLocaleCountryCode;
    NSLog(@"deviceName %@ ",deviceName);
    NSLog(@"deviceCountryCode %@",deviceCountryCode);
    NSLog(@"lanarr %@",lanarr);
}


void initHwSDK(char * serverURL){
//    NSLog(@"initHwSDK GameAnalytics");
//    [GameAnalytics configureBuild:@"alpha 0.9.9"];
//    [GameAnalytics configureAutoDetectAppVersion:YES];
//    [GameAnalytics initializeWithGameKey:@"abff94d0ed3f2bc347f5c300133ae92f" gameSecret:@"bc84129b62b64c24418e6755515f1c005604d531"];
    
    
    NSLog(@"initHwSDK == %s",serverURL);
    HwAdsInterface* hwAdsInterface = [HwAdsInterface sharedInstance];
    
    NSString *serverString = [NSString stringWithFormat:@"%s",serverURL];
    
    //int projectID = [serverString intValue];
    int projectID = 127;
    
    //新版本只需要传一个参数
    [[HwAds instance] initSDK:projectID  isFirebase:YES isABTestOpen:NO];
    NSLog(@"HwPurchase HwPurchase HwPurchaseHwPurchaseHwPurchaseHwPurchase");
//    [[HwAds instance] hwAnalyticsEvent:@"HwPurchase" action:@"US" label:@"1.99"];
    
    
    //关联回调的代码
    HwAds* hwads = [HwAds instance];
    hwads.hwAdsDelegate = hwAdsInterface;
    hwads.hwAdsInterDelegate = hwAdsInterface;
    hwads.hwAdsBannerDelegate = hwAdsInterface;
}

void loadHwInterAd(){
    NSLog(@"call loadInterAd");
     //新版本不需要调用主动调用加载的方法
    //[[HwAds instance] loadInter];
}

void showHwInterAd(){
    NSLog(@"call ShowInterAd 11111111111111");
    //[[HwAds instance] hideBanner];
    [[HwAds instance] showInter];
}

BOOL isHwInterAdLoaded(){
    NSLog(@"call isInterLoaded");
    return [[HwAds instance] isInterLoad];
}

void loadHwRewardAd(){
    NSLog(@"call loadRewardedVideo");
    //新版本不需要调用主动调用加载的方法
    //[[HwAds instance] loadReward];
}

void showHwRewardAd(char * tag){
    NSLog(@"call showRewardedVideo");
    [[HwAds instance] showReward:[NSString stringWithUTF8String:tag]];
//    if([[HwAds instance] isBannerLoad]){
//        NSLog(@"call isBannerLoad");
//         [[HwAds instance] showBanner];
//    }
}

BOOL isHwRewardAdLoaded(){
    bool isLoaded = [[HwAds instance] isRewardLoad];
    NSLog(@"call isRewardLoaded %i",isLoaded?"yes":"no");
    return [[HwAds instance] isRewardLoad];
}

void hwFbEvent(char * category, char * action, char * label){
    NSLog(@"call hwFbEvent");
//    [[HwAds instance] hwAnalyticsEvent:[NSString stringWithUTF8String:category] action:[NSString stringWithUTF8String:action]label:[NSString stringWithUTF8String:label]];
}
