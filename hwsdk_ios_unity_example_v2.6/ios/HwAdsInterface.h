//
//  HwAdsInterface_h
//  Unity-iPhone
//
//  Created by game team on 2019/11/15.
//

#ifndef HwAdsInterface_h
#define HwAdsInterface_h


#import <Foundation/Foundation.h>

#import <HwAdsFramework/HwAdsFramework.h>
#import <HwAdsFramework/HwAds.h>

@interface HwAdsInterface : NSObject<HwAdsDelegate, HWAdsInterDelegate>
//add
@property (nonatomic,strong) HwAds *hwAds;

+(id) sharedInstance;

- (void)initHwSDK:(NSString *)serverURL;
- (void)loadHwInterAd;
- (void)showHwInterAd;
- (BOOL)isHwInterAdLoaded;
- (void)loadHwRewardAd;
- (void)showHwRewardAd:(NSString *)tag;
- (BOOL)isHwRewardAdLoaded;
//faceboook 打点非必须
- (void)hwFbEvent:(NSString *)category
           action:(NSString *)action
            label:(NSString *)label;
@end

#endif /* HwAdsCall_h */
