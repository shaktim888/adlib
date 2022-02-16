//
//  FullScreenAdController.m
//  adlib
//
//  Created by admin on 2020/4/10.
//

#import "FullScreenAdController.h"
#import <BUAdSDK/BUFullscreenVideoAd.h>
#import "AdIds.h"

@interface FullScreenAdController () <BUFullscreenVideoAdDelegate>
{
    bool isSkiped;
}
@property (nonatomic, strong) BUFullscreenVideoAd *fullscreenVideoAd;
@end

@implementation FullScreenAdController

- (void) showAds : (bool) isLandscape
{
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:isLandscape ? normal_fullscreen_landscape_ID : normal_fullscreen_portrait_ID];
    self.fullscreenVideoAd.delegate = self;
    isSkiped = false;
    [self.fullscreenVideoAd loadAdData];
}

#pragma mark BURewardedVideoAdDelegate
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.fullscreenVideoAd showAdFromRootViewController:[self appRootViewController]];
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
    
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    isSkiped = true;
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    callback(!isSkiped);
}

@end


