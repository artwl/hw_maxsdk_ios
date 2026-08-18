//
//  HwAdsInterface.m
//  iOS_SDK_V9.8.13
//
//  Created by cuili qi on 2022/4/28.
//

#import "HwAdsInterface.h"

extern void UnitySendMessage(const char *obj, const char *method, const char *msg);

@implementation HwAdsInterface
static HwAdsInterface *hwAdsInterfaceInstance;
+ (id) sharedInstance{
    if(hwAdsInterfaceInstance == nil){
        NSLog(@"shareInstance");
        hwAdsInterfaceInstance = [[self alloc] init];
    }
    return hwAdsInterfaceInstance;
}
#pragma MARK HwAdsDelegate-激励广告的代理方法

//加载成功  添加delegate
- (void)hwAdsRewardedVideoLoadSuccess{
    NSLog(@"callback-hwAdsRewardedVideoLoadSuccess");
}
//加载失败
- (void)hwAdsRewardedVideoLoadFailWithErrorCode:(NSInteger)errorCode{
    NSLog(@"callback-hwAdsRewardedVideoLoadFailWithErrorCode:%ld", (long)errorCode);
    UnitySendMessage("HwAdsCallBack", "RewardCallBack", "false");

}
//播放失败，不给奖励
- (void)hwAdsRewardedVideoPlayFailWithErrorCode:(NSInteger)errorCode{
    NSLog(@"callback-hwAdsRewardedVideoPlayFailWithErrorCode:%ld", (long)errorCode);
    UnitySendMessage("HwAdsCallBack", "RewardCallBack", "false");

}
//广告展示
- (void)hwAdsRewardedVideoDidAppear{
    NSLog(@"callback-hwAdsRewardedVideoDidAppear");

}
//广告关闭
- (void)hwAdsRewardedVideoClose{
    NSLog(@"callback-hwAdsRewardedVideoClos");

}
//广告被点击
- (void)hwAdsRewardedVideoClick{
    NSLog(@"callback-hwAdsRewardedVideoClick");

}
//广告播放完成，给奖励，最好在这里做标记，在close中给奖励
- (void)hwAdsRewardedVideoGiveReward
{
    NSLog(@"callback-hwAdsRewardedVideoGiveReward");
    UnitySendMessage("HwAdsCallBack", "RewardCallBack", "true");

}
//广告即将展示，建议在收到这个回调时，暂停游戏；
- (void)hwAdsRewardedVideoWillAppear{
    NSLog(@"callback-hwAdsRewardedVideoWillAppear");

}
//获取激励广告收入
- (void)hwAdsRewardedVideoPayRevenueForAd:(double)revenue{
    NSLog(@"callback-hwAdsRewardedVideoPayRevenueForAd:%f", revenue);

}
#pragma MARK--BANNE广告的代理方法
- (void)hwAdsBannerLoadSuccess{
    NSLog(@"callback-hwAdsBannerLoadSuccess");

}
#pragma MARK -插屏广告的代理
//插屏加载
- (void)hwAdsInterstitialLoadSuccess{
    NSLog(@"callback-hwAdsInterstitialLoadSuccess");

}
//加载失败
- (void)hwAdsInterstitialLoadFail{
    NSLog(@"callback-hwAdsInterstitialLoadFail");

}
//插屏点击 add 3.0
- (void)hwAdsInterstitialClick{
    NSLog(@"callback-hwAdsInterstitialClick");

}
//插屏播放 add 3.0
- (void)hwAdsInterstitialShow{
    NSLog(@"callback-hwAdsInterstitialShow");

}
//插屏关闭 add 3.0
- (void)hwAdsInterstitialClose{
    NSLog(@"callback-hwAdsInterstitialClose");
    UnitySendMessage("HwAdsCallBack", "InterCallBack", "true");

}
//插屏展示失败 add 9.5.2
- (void)hwAdsInterstitialFailToShowWithErrorCode:(NSInteger)errorCode{
    NSLog(@"callback-hwAdsInterstitialFailToShowWithErrorCode:%ld", (long)errorCode);
    UnitySendMessage("HwAdsCallBack", "InterCallBack", "false");

}
//获取插屏广告收入
- (void)hwAdsInterstitialPayRevenueForAd:(double)revenue{
    NSLog(@"callback-hwAdsInterstitialPayRevenueForAd:%f", revenue);

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


void initHwSDK(int serverURL, BOOL isFirebase, BOOL isABTestOpen, BOOL isMerge){
    NSLog(@"HWLog : %d", serverURL);
    HwAdsInterface* hwAdsInterface = [HwAdsInterface sharedInstance];
    [[HwAds instance] initSDK:serverURL isFirebase:isFirebase isABTestOpen:isABTestOpen isMerge:isMerge];
    //关联回调的代码
    HwAds* hwads = [HwAds instance];
    hwads.hwAdsDelegate = hwAdsInterface;
    hwads.hwAdsInterDelegate = hwAdsInterface;
    hwads.hwAdsBannerDelegate = hwAdsInterface;
}

//banner
void showHwBannerAd(){
    [[HwAds instance] showBanner];
    
}
void hideHwBannerAd(){
    [[HwAds instance] hideBanner];
    
}
BOOL isHwBannerAdLoaded(){
    return [[HwAds instance] isBannerLoad];
}
//inter
void showHwInterAd(){
    [[HwAds instance] showInter];
}
BOOL isHwInterAdLoaded(){
    return [[HwAds instance] isInterLoad];
}
//reward
void showHwRewardAd(char * tag){
    [[HwAds instance] showReward:[NSString stringWithUTF8String:tag]];

}
BOOL isHwRewardAdLoaded(){
    return [[HwAds instance] isRewardLoad];
}

//内购打点
void hwAnalyticsPurchase(char * dollers,char * currency,char *productId,char *productName,int purchaseType,char * orderId,char *purchaseToken){

    [[HwAds instance] hwAnalyticsPurchaseByNumberOfDollars:[NSString stringWithUTF8String:dollers] currency:[NSString stringWithUTF8String:currency] productId:[NSString stringWithUTF8String:productId] productName:[NSString stringWithUTF8String:productName] purchaseType:purchaseType orderId:[NSString stringWithUTF8String:orderId] purchaseToken:[NSString stringWithUTF8String:purchaseToken]];

}

//sdk版本号
const char *hwSdkVersion(void){
    static NSString * version = nil;
    version = [HwAds sdkVersion];

    return [version UTF8String];
}
