//
//  HwAdsInterface.h
//  iOS_SDK_V9.2.0
//
//  Created by cuili qi on 2022/4/28.
//
#ifndef HwAdsInterface_h
#define HwAdsInterface_h

#import <Foundation/Foundation.h>
#import <HwAdsFramework/HwAds.h>


@interface HwAdsInterface : NSObject<HwAdsDelegate,HWAdsBannerDelegate,HWAdsInterDelegate>
@property (nonatomic,strong) HwAds *hwAds;

+(id) sharedInstance;
@end

void initHwSDK(int serverURL);
//banner
void showHwBannerAd();
void hideHwBannerAd();
BOOL isHwBannerAdLoaded();
//inter
void showHwInterAd();
BOOL isHwInterAdLoaded();
//reward
void showHwRewardAd(char * tag);
BOOL isHwRewardAdLoaded();

//内购打点
void hwAnalyticsPurchase(char * dollers,char *productId,int purchaseType,char * orderId,char *purchaseToken);

//sdk版本号
char hwSdkVersion();
//上传日志到SDK后台--传
void reportLogByID(int serverURL);

#endif
