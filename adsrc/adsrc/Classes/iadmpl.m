
#import <BUAdSDK/BUAdSDKManager.h>
#import "FullScreenAdController.h"
#import "SplashAdController.h"
#import "InterstitialAdController.h"
#import "BannerAdContoller.h"
#import "RewardAdController.h"
#import "AdHelper.h"


FullScreenAdController * fullController;
SplashAdController * splashAdController;
InterstitialAdController * interstitialAdController;
BannerAdContoller * bannerAdController;
RewardAdController * rewardAdController;

static bool isInited = false;
static void initSDK()
{
    if(!isInited) {
        isInited = true;
        [BUAdSDKManager setAppID:@"5000546"];
#if DEBUG
        // Whether to open log. default is none.
        [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
#endif
        [BUAdSDKManager setIsPaidApp:NO];
    }
}

static void waitWindow(void(^onready)(void))
{
    UIApplication * app = [UIApplication sharedApplication];
    if(app) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if(keyWindow) {
            dispatch_async(dispatch_get_main_queue(), ^{
                onready();
            });
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                waitWindow(onready);
            });
        }
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            waitWindow(onready);
        });
    }
}

NSMutableDictionary * cbDict;

void showAds(ADS_TYPES type, void(^cb)(bool)  )
{
    initSDK();
    if(!cbDict) {
        cbDict = [[NSMutableDictionary alloc] init];
    }
    if(cb) {
        [cbDict setObject:cb forKey:@(type)];
    } else {
        [cbDict removeObjectForKey:@(type)];
    }
    waitWindow(^{
        switch (type) {
            case ADS_FULLSCREEN_PORTRAIT:
            case ADS_FULLSCREEN_LANDSCAPE:
            {
                if(!fullController) {
                    fullController = [[FullScreenAdController alloc] initWithCallback:^(bool isOk){
                        void(^last_cb)(bool);
                        last_cb = [cbDict objectForKey:@(type)];
                        if(last_cb) last_cb(isOk);
                    }];
                }
                [fullController showAds:ADS_FULLSCREEN_LANDSCAPE == type];
                break;
            }
            case ADS_SPLASH:
            {
                if(!splashAdController) {
                    splashAdController = [[SplashAdController alloc] initWithCallback:^(bool isOk){
                        void(^last_cb)(bool);
                        last_cb = [cbDict objectForKey:@(type)];
                        if(last_cb) last_cb(isOk);
                    }];
                }
                [splashAdController showAds];
                break;
            }
            case ADS_INTERSTITIAL:
            {
                if(!interstitialAdController) {
                    interstitialAdController = [[InterstitialAdController alloc] initWithCallback:^(bool isOk){
                        void(^last_cb)(bool);
                        last_cb = [cbDict objectForKey:@(type)];
                        if(last_cb) last_cb(isOk);
                    }];
                }
                [interstitialAdController showAds];
                break;
            }
            case ADS_BANNER:
            case ADS_BANNER_AUTO_SWITCH:
            {
                if(!bannerAdController) {
                    bannerAdController = [[BannerAdContoller alloc] initWithCallback:^(bool isOk){
                        void(^last_cb)(bool);
                        last_cb = [cbDict objectForKey:@(type)];
                        if(last_cb) last_cb(isOk);
                    }];
                }
                [bannerAdController showAds:type == ADS_BANNER_AUTO_SWITCH];
                break;
            }
            case ADS_REWARD_LANDSCAPE:
            case ADS_REWARD_PORTRAIT:
            {
                if(!rewardAdController) {
                    rewardAdController = [[RewardAdController alloc] initWithCallback:^(bool isOk){
                        void(^last_cb)(bool);
                        last_cb = [cbDict objectForKey:@(type)];
                        if(last_cb) last_cb(isOk);
                    }];
                }
                [rewardAdController showAds:type == ADS_REWARD_LANDSCAPE];
                break;
            }
            default:
                break;
        }
    });
}
