//
//  HwAdsInterface_h
//  Unity-iPhone
//
//  Created by game team on 2019/11/15.
//

#ifndef HwAdsInterface_h
#define HwAdsInterface_h


#import <Foundation/Foundation.h>

@interface HwAdsInterface : NSObject<HwAdsDelegate,HWAdsInterDelegate>
//add
@property (nonatomic,strong) HwAds *hwAds;

+(id) sharedInstance;

@end


void initHwSDK(char *serverURL);
void loadHwInterAd();
void showHwInterAd();
BOOL isHwInterAdLoaded();
void loadHwRewardAd();
void showHwRewardAd(char * tag);
BOOL isHwRewardAdLoaded();

void hwFbEvent(char * category, char * action, char * label);








#endif /* HwAdsCall_h */

//@interface HwAdsInterface : NSObject<HwAdsDelegate>
//@property (nonatomic, strong) HwAds *hwAdsDelegate;
//
//- (void)initTest;
//@end


