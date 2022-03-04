//
//  HwAdsCocos.h
//  hello_world_cocos_sdk_demo-mobile
//
//  Created by artwl on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import <HwAdsFramework/HwAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface HwAdsCocos : NSObject<HWAdsBannerDelegate,HwAdsDelegate,HWAdsInterDelegate>

+(void)initSDK:(NSNumber *)id;

+(BOOL)isVideoAdLoaded;

+(void)showVideoAd;

+(BOOL)isInterAdLoaded;

+(void)showInterAd;

+(BOOL)isBannerAdLoaded;

+(void)showBannerAd;

+(void)hideBannerAd;

@end

NS_ASSUME_NONNULL_END
