//
//  HwAdsInterface.m
//  iOS_SDK_V9.2.0
//
//  Created by cuili qi on 2022/4/28.
//

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
#pragma MARK HwAdsDelegate-激励广告的代理方法

//加载成功  添加delegate
- (void)hwAdsRewardedVideoLoadSuccess{
    NSLog(@"callback-hwAdsRewardedVideoLoadSuccess");
}
//加载失败
- (void)hwAdsRewardedVideoLoadFail{
    NSLog(@"callback-hwAdsRewardedVideoLoadFail");

}
//播放失败，不给奖励
- (void)hwAdsRewardedVideoPlayFail{
    NSLog(@"callback-hwAdsRewardedVideoPlayFail");

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

}
//广告即将展示，建议在收到这个回调时，暂停游戏；
- (void)hwAdsRewardedVideoWillAppear{
    NSLog(@"callback-hwAdsRewardedVideoWillAppear");

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


void initHwSDK(int serverURL){

    HwAdsInterface* hwAdsInterface = [HwAdsInterface sharedInstance];
    //新版本只需要传一个参数
    [[HwAds instance] initSDK:serverURL isFirebase:YES isABTestOpen:NO];
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
void hwAnalyticsPurchase(char * dollers,char *productId,int purchaseType,char * orderId,char *purchaseToken){
    
    [[HwAds instance] hwAnalyticsPurchaseByNumberOfDollars:[NSString stringWithUTF8String:dollers] productId:[NSString stringWithUTF8String:productId] purchaseType:purchaseType orderId:[NSString stringWithUTF8String:orderId] purchaseToken:[NSString stringWithUTF8String:purchaseToken]];
    
}

//sdk版本号
char hwSdkVersion(){
    NSString * version =[[HwAds instance] sdkVersion];

    return [version UTF8String];
}
//上传日志到SDK后台--传
void reportLogByID(int serverURL){
    [[HwAds instance] reportLogByID:serverURL];
    
}

