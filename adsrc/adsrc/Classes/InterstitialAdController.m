//
//  FullScreenAdController.m
//  adlib
//
//  Created by admin on 2020/4/10.
//

#import "InterstitialAdController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "AdIds.h"


@interface InterstitialAdController () <BUInterstitialAdDelegate>

@property (nonatomic, strong) BUInterstitialAd *adView;
@end

@implementation InterstitialAdController

- (void) showAds
{
    self.adView= [[BUInterstitialAd alloc] initWithSlotID:normal_interstitial_ID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
    self.adView.delegate = self;
    [self.adView loadAdData];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
    callback(true);
}


- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    [self.adView showAdFromRootViewController:[self appRootViewController]];
}


- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"interstitialAd data load fail");
    callback(false);
}

- (void)interstitialAdDidCloseOtherController:(BUInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {

}

@end


