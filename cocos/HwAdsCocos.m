//
//  HwAdsCocos.m
//  hello_world_cocos_sdk_demo-mobile
//
//  Created by artwl on 2022/3/4.
//

#import "HwAdsCocos.h"

@interface HwAdsCocos()<HWAdsBannerDelegate,HwAdsDelegate,HWAdsInterDelegate>

@property(nonatomic, strong, readwrite) HwAds *hwads;

@end

@implementation HwAdsCocos

+ (id)sharedInstance{
    static HwAdsCocos * ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:nil] init];
    });

    return ins;
}

+(id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

-(id)copyWithZone:(NSZone *) zone {
    return [[self class] sharedInstance];
}

-(id)mutableCopyWithZone:(NSZone *) zone {
    return [[self class] sharedInstance];
}

NSString *const LogTag = @"HWADS_COCOS_DEMO";

+(void)initSDK:(NSNumber *)id{
    NSLog(@"%@ initSDK", LogTag);
    [[HwAdsCocos sharedInstance] _initSDKWithId:id];
}

+(BOOL)isVideoAdLoaded{
    NSLog(@"%@ isVideoAdLoaded", LogTag);
    return [[[HwAdsCocos sharedInstance] hwads] isRewardLoad];
}

+(void)showVideoAd{
    NSLog(@"%@ showVideoAd", LogTag);
    [[HwAdsCocos sharedInstance] _showVideoAd];
}

+(BOOL)isInterAdLoaded{
    NSLog(@"%@ isInterAdLoaded", LogTag);
    return [[[HwAdsCocos sharedInstance] hwads] isInterLoad];
}

+(void)showInterAd{
    NSLog(@"%@ showInterAd", LogTag);
    [[HwAdsCocos sharedInstance] _showInterAd];
}

+(BOOL)isBannerAdLoaded{
    NSLog(@"%@ isBannerAdLoaded", LogTag);
    return [[[HwAdsCocos sharedInstance] hwads] isBannerLoad];
}

+(void)showBannerAd{
    NSLog(@"%@ showBannerAd", LogTag);
    [[HwAdsCocos sharedInstance] _showBannerAd];
}

+(void)hideBannerAd{
    NSLog(@"%@ hideBannerAd", LogTag);
    [[HwAdsCocos sharedInstance] _hideBannerAd];
}

-(void)_initSDKWithId:(NSNumber *)id{
    self.hwads = [HwAds instance];
    [self.hwads initSDK:id];
    self.hwads.hwAdsDelegate = self;
    self.hwads.hwAdsInterDelegate = self;
    self.hwads.hwAdsBannerDelegate = self;
}

-(void)_showVideoAd {
    if ([self.hwads isRewardLoad]) {
        NSLog(@"%@ call showReward", LogTag);
        [self.hwads showReward:@"Demo"];
    } else {
        NSLog(@"%@ call showReward failed: video ad not loaded", LogTag);
    }
}

-(void)_showInterAd {
    if ([self.hwads isInterLoad]) {
        NSLog(@"%@ call showInter", LogTag);
        [self.hwads showInter];
    } else {
        NSLog(@"%@ call showInter failed: inter ad not loaded", LogTag);
    }
}

-(void)_showBannerAd {
    if ([self.hwads isBannerLoad]) {
        NSLog(@"%@ call showBanner", LogTag);
        [self.hwads showBanner];
    } else {
        NSLog(@"%@ call showBanner failed: banner ad not loaded", LogTag);
    }
}

-(void)_hideBannerAd {
    if ([self.hwads isBannerLoad]) {
        NSLog(@"%@ call hideBanner", LogTag);
        [self.hwads hideBanner];
    } else {
        NSLog(@"%@ call hideBanner failed: banner ad not loaded", LogTag);
    }
}

#pragma mark HwAdsVideoDelegate
//广告加载成功，收到这个回调
- (void) hwAdsRewardedVideoLoadSuccess {
    NSLog(@"%@ video ad load success", LogTag);
}

//广告调用了show方法，收到这个回调
- (void)hwAdsRewardedVideoWillAppear {
    NSLog(@"%@ video ad will appear", LogTag);
}

//广告显示，调用这个回调
- (void)hwAdsRewardedVideoDidAppear {
    NSLog(@"%@ video ad show", LogTag);
}

//广告播放完成，给用户奖励
- (void) hwAdsRewardedVideoGiveReward {
    NSLog(@"%@ video ad need give reward", LogTag);
}

//广告关闭
- (void) hwAdsRewardedVideoClose {
    NSLog(@"%@ video ad close", LogTag);
}

//广告点击回调
- (void) hwAdsRewardedVideoClick {
    NSLog(@"%@ video ad click", LogTag);
}

//广告加载失败
- (void) hwAdsRewardedVideoLoadFail {
    NSLog(@"%@ video ad load fail", LogTag);
}

//广告播放失败，不给用户奖励
- (void)hwAdsRewardedVideoPlayFail {
    NSLog(@"%@ video ad play fail", LogTag);
}

#pragma HWAdsInterDelegate
//插屏播放
- (void)hwAdsInterstitialShow {
    NSLog(@"%@ inter ad show", LogTag);
}
//插屏关闭
- (void)hwAdsInterstitialClose {
    NSLog(@"%@ inter ad close", LogTag);
}

//add
- (void)hwAdsInterstitialLoadSuccess {
    NSLog(@"%@ inter ad load success", LogTag);
}
- (void)hwAdsInterstitialLoadFail {
    NSLog(@"%@ inter ad load fail", LogTag);
}
- (void)hwAdsInterstitialClick {
    NSLog(@"%@ inter ad click", LogTag);
}

#pragma HwAdsBannerDelegate
- (void)hwAdsBannerLoadSuccess {
    NSLog(@"%@ banner ad load success", LogTag);
}

@end
