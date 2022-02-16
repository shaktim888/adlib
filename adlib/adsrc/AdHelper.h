//
//  AdHelper.h
//  adlib
//
//  Created by admin on 2020/4/10.
//

#ifndef AdHelper_h
#define AdHelper_h

typedef enum
{
    ADS_REWARD_LANDSCAPE,
    ADS_REWARD_PORTRAIT,
    ADS_SPLASH,
    ADS_INTERSTITIAL,
    ADS_BANNER,
    ADS_BANNER_AUTO_SWITCH,
    ADS_FULLSCREEN_LANDSCAPE,
    ADS_FULLSCREEN_PORTRAIT,
} ADS_TYPES;

#if defined(__cplusplus)
extern "C" {
#endif

FOUNDATION_EXPORT void showAds(ADS_TYPES type, void(^cb)(bool));


#if defined(__cplusplus)
}
#endif
#endif /* AdHelper_h */
