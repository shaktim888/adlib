//
//  BannerAdContoller.m
//  adlib
//
//  Created by admin on 2020/4/13.
//

#import "BannerAdContoller.h"
#import "AdIds.h"
#import <BUAdSDK/BUBannerAdView.h>

@interface BannerAdContoller () <BUBannerAdViewDelegate>
@property(nonatomic, strong) BUBannerAdView *bannerView;
@end


@implementation BannerAdContoller

- (void)showAds : (bool) isAutoSwitch {
    if(self.bannerView)
    {
        [self.bannerView removeFromSuperview];
    }
    
    BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_90];
    UIViewController * rootViewController = [self appRootViewController];
    if (isAutoSwitch) {
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:normal_banner_ID size:size rootViewController:rootViewController interval:30];
    } else {
        self.bannerView = [[BUBannerAdView alloc] initWithSlotID:normal_banner_ID size:size rootViewController:rootViewController];
    }
    const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    const CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat bannerHeight = screenWidth * size.height / size.width;
    self.bannerView.frame = CGRectMake(0, screenHeight - bannerHeight, screenWidth, bannerHeight);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    [rootViewController.view addSubview:self.bannerView];
}

- (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    callback(true);
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    
}

- (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
    
}

- (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    callback(false);
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        if (self.bannerView == bannerAdView) {
            self.bannerView = nil;
        }
    }];
}

- (void)bannerAdViewDidCloseOtherController:(BUBannerAdView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    
}
@end
