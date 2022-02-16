//
//  ADBaseController.h
//  adlib
//
//  Created by admin on 2020/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADBaseController : NSObject
{
    void(^callback)(bool);
}
- (instancetype)initWithCallback:(void(^)(bool))_cb;
- (UIViewController *)appRootViewController;
@end

NS_ASSUME_NONNULL_END
