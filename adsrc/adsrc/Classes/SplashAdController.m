//
//  FullScreenAdController.m
//  adlib
//
//  Created by admin on 2020/4/10.
//

#import "SplashAdController.h"
#import <BUAdSDK/BUSplashAdView.h>
#import "AdIds.h"


@interface SplashAdController () <BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAdView *adView;
@end

@implementation SplashAdController

- (void) showAds
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.adView= [[BUSplashAdView alloc] initWithSlotID:normal_splash_ID frame:frame];
    self.adView.delegate = self;
    UIViewController * controller = [self appRootViewController];
    [self.adView loadAdData];
    [controller.view addSubview:self.adView];
    
    self.adView.rootViewController = controller;
}

#pragma mark BURewardedVideoAdDelegate

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    [self.adView removeFromSuperview];
    callback(true);
    self.adView = nil;
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    [self.adView removeFromSuperview];
    callback(false);
    self.adView = nil;
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd
{
    
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
}

@end


