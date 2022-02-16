//
//  FullScreenAdController.m
//  adlib
//
//  Created by admin on 2020/4/10.
//

#import "RewardAdController.h"
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>
#import "AdIds.h"

@interface RewardAdController () <BURewardedVideoAdDelegate>
{
    bool isSkiped;
}
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@end

@implementation RewardAdController

- (void) showAds : (bool) isLandscape
{
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"ios";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:isLandscape ? normal_reward_landscape_ID : normal_reward_ID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
}

#pragma mark BURewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
   if (self.rewardedVideoAd) {
       [self.rewardedVideoAd showAdFromRootViewController:[self appRootViewController]];
   }
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if(error) {
        callback(false);
    }
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    callback(!isSkiped);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if(error) {
        callback(false);
    }
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd
{
    isSkiped = true;
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    
}

- (void)rewardedVideoAdClientRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd {
   
}


@end


