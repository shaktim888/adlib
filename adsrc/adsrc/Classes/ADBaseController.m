//
//  ADBaseController.m
//  adlib
//
//  Created by admin on 2020/4/13.
//

#import "ADBaseController.h"

@implementation ADBaseController

- (instancetype)initWithCallback:(void(^)(bool))_cb {
    self = [self init];
    if (!self) {
        return nil;
    }
    callback = _cb;
    return self;
}


- (UIViewController *)appRootViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    UIViewController * tempVc = nil;
    while (vc)
    {
        tempVc = vc;
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
        else
        {
            vc = vc.presentedViewController;
        }
    }
    return tempVc;
}

@end
