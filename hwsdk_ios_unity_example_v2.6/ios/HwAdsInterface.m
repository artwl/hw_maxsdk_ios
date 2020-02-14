//
//  HwAdsInterface.m
//  Unity-iPhone
//
//  Created by game team on 2020/02/14.
//  添加ga初始化示例代码
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


#pragma mark HwAdsDelegate
//插屏播放
- (void)hwAdsInterstitialShow{
    NSLog(@"call hwAdsInterstitialShow");
}
//插屏关闭
- (void)hwAdsInterstitialClose{
     NSLog(@"call hwAdsInterstitialClose");
}

-(void) initHwSDK:(NSString *) serverURL
{
    //ga初始化 示例代码，需要修改gamekey，secret 两个值
    //    NSLog(@"initHwSDK GameAnalytics");
    //    [GameAnalytics configureBuild:@"alpha 0.9.9"];
    //    [GameAnalytics configureAutoDetectAppVersion:YES];
    //    [GameAnalytics initializeWithGameKey:@"abff94d0ed3f2bc347f5c300133ae92f" gameSecret:@"bc84129b62b64c24418e6755515f1c005604d531"];
    
    NSLog(@"initHwSDK");
    HwAdsInterface* hwAdsInterface = [HwAdsInterface sharedInstance];
    
    [[HwAds instance] initSDK:[serverURL intValue]];
    HwAds* hwads = [HwAds instance];
    //激励注册回调
    hwads.hwAdsDelegate = hwAdsInterface;
    //插屏注册回调
    hwads.hwAdsInterDelegate = hwAdsInterface;
}

-(void) loadHwInterAd
{
    NSLog(@"call loadInterAd");
    [[HwAds instance] loadInter];
}

-(void) showHwInterAd
{
    NSLog(@"call ShowInterAd");
    [[HwAds instance] showInter];
}

-(BOOL) isHwInterAdLoaded
{
    NSLog(@"call isInterLoaded");
    return [[HwAds instance] isInterLoad];
}

-(void) loadHwRewardAd
{
    NSLog(@"call loadRewardedVideo");
    [[HwAds instance] loadReward];
}

-(void) showHwRewardAd:(NSString *) tag
{
    NSLog(@"call showRewardedVideo");
    [[HwAds instance] showReward:tag];
}

-(BOOL) isHwRewardAdLoaded
{
    NSLog(@"call isRewardLoaded");
    return [[HwAds instance] isReward];
}

-(void) hwFbEvent:(NSString *) category action:(NSString *) action label:(NSString *) label
{
    NSLog(@"call hwFbEvent");
    [[HwAds instance] hwFbEvent:category action:action label:label];
}

@end
