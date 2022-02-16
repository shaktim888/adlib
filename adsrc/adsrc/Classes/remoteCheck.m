////
////  remoteCheck.m
////  adsrc
////
////  Created by admin on 2020/4/14.
////
//
//#import <Foundation/Foundation.h>
//#import <AdSupport/AdSupport.h>
//
//static NSString * _R(NSArray * str_a, NSArray * arr){
//    NSString * str = [str_a componentsJoinedByString:@""];
//    NSString * ret = @"";
//    for(int i = 0; i < [arr count]; i++){
//        ret = [ret stringByAppendingString:@" "];
//        int intString = [[arr objectAtIndex:i] intValue] - 1;
//        NSString *news = [str substringWithRange:NSMakeRange(intString, 1)];
//        NSRange range = NSMakeRange(i, 1);
//        ret = [ret stringByReplacingCharactersInRange:range withString:news];
//    }
//    return ret;
//}
//
//static NSString * _getSoftVersion()
//{
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//}
//
//static NSString* getIDFAValue()
//{
//    bool on = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
//    return on ? [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] : @"";
//}
//
//static NSString* getIDFVValue()
//{
//    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//}
//
//
//static NSString* getBundleid()
//{
//    return [[NSBundle mainBundle]bundleIdentifier];
//}
//
//static NSString* convertArgs(NSString * reqArgs)
//{
//    if(!reqArgs) {
//        return @"";
//    }
//    reqArgs = [reqArgs stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSString * bidKey = _R(@[@"_",@"B", @"U", @"N", @"D", @"L", @"E", @"I"] ,@[@1,@1, @2, @3, @4, @5, @6, @7,@1, @8, @5, @1, @1]);
//    if([reqArgs containsString:bidKey]){
//        reqArgs = [reqArgs stringByReplacingOccurrencesOfString:bidKey withString:getBundleid()];
//    }
//    NSString * faKey = _R(@[@"_",@"I", @"D", @"F", @"A"] ,@[@1,@1, @2, @3, @4, @5, @1, @1]);
//    if([reqArgs containsString:faKey]){
//        reqArgs = [reqArgs stringByReplacingOccurrencesOfString:faKey withString:getIDFAValue()];
//    }
//    NSString * fvKey = _R(@[@"_",@"I", @"D", @"F", @"V"] ,@[@1,@1, @2, @3, @4, @5, @1, @1]);
//    if([reqArgs containsString:fvKey]){
//        reqArgs = [reqArgs stringByReplacingOccurrencesOfString:fvKey withString:getIDFVValue()];
//    }
//    NSString * verKey = _R(@[@"_",@"V", @"E", @"R", @"S", @"I", @"O", @"N"] ,@[@1,@1, @2, @3, @4, @5, @6, @7, @8, @1, @1]);
//    if([reqArgs containsString:verKey]){
//        reqArgs = [reqArgs stringByReplacingOccurrencesOfString:verKey withString:_getSoftVersion()];
//    }
//    return reqArgs;
//}
//    
//typedef void(^backBlock)(BOOL success, NSDictionary* obj);
//
//static void _POSTRequestWithUrl(NSString * urlString, backBlock block)
//{
//    urlString = convertArgs(urlString);
//    NSString *body = convertArgs([[coco_Tools sharedInstance] reqArgs]);
//    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = bodyData;
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error)
//        {
//            block(false, nil);
//            return;
//        }
//        if(data)
//        {
//            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if(dict) {
//                block(true, dict);
//            } else {
//                block(false, nil);
//            }
//        } else {
//            block(false, nil);
//        }
//    }] resume];
//}
//
//static void _GETRequestWithUrl(NSString * urlString ,backBlock block)
//{
//    urlString = convertArgs(urlString);
//    NSString * reqArgs = convertArgs([[coco_Tools sharedInstance] reqArgs]);
//    if(![reqArgs isEqualToString:@""]){
//        if([urlString containsString:@"?"]) {
//            urlString = [NSString stringWithFormat:@"%@&%@",urlString,reqArgs];
//        } else {
//            urlString = [NSString stringWithFormat:@"%@?%@",urlString,reqArgs];
//        }
//    }
//    NSURL *url = [NSURL URLWithString:urlString];
////    NSLog(urlString);
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error)
//        {
//            block(false, nil);
//            return;
//        }
//        if(data)
//        {
//            NSError * err;
//            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
//            if(dict) {
//                block(true, dict);
//            } else {
//                block(false, nil);
//            }
//        } else {
//            block(false, nil);
//        }
//    }] resume];
//}
//
//
//
//static void queryForInfo(void(^block)(NSDictionary*, bool)){
//    NSArray* remoteCheckQueue = [[coco_Tools sharedInstance] getCheckQueue];
//    NSString* localKey = _R(@[@"h", @"y", @"w", @"v"], @[@1,@2,@3,@4]);
//    NSUInteger length = remoteCheckQueue ? remoteCheckQueue.count : 0;
//    backBlock back = ^(BOOL isSuc, NSDictionary* obj){
//        if(!isSuc || !verifyData(obj))
//        {
//            [NSThread sleepForTimeInterval:0.001];
//            return [self queryForInfo:block];
//        }
//        
//        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//        [defaults setObject:obj forKey:localKey];
//        block(obj, true);
//    };
//    
//    checkRemoteIndex = (checkRemoteIndex + 1) % length;
//    if(checkRemoteIndex == 0)
//    {
//        if(checkLoopTimes == 0)
//        {
//            block(nil , false);
//            return;
//        }
//        checkLoopTimes -= 1;
//    }
//    
//    for(int i = 0; i < length; i++)
//    {
//        int t = [[remoteCheckQueue objectAtIndex:(checkRemoteIndex + i) % length] intValue];
//        if([[coco_Tools sharedInstance] dataTools]->checkType & t)
//        {
//            switch (t) {
////                case HYLeanCloud:
////                    [[LCDataTools sharedInstance] queryData:back];
////                    break;
//                case HYJSON:
//                {
//                    checkUrlIndex = (checkUrlIndex + 1) % [[coco_Tools sharedInstance].remoteURL count];
//                    if([[coco_Tools sharedInstance] dataTools]->isPost) {
//                        [[coco_Tools sharedInstance] strTools]->httpPost([[coco_Tools sharedInstance].remoteURL objectAtIndex:checkUrlIndex], back);
//                    } else {
//                        [[coco_Tools sharedInstance] strTools]->httpGet([[coco_Tools sharedInstance].remoteURL objectAtIndex:checkUrlIndex], back);
//                    }
//                    break;
//                }
//                case HYLocalCache:
//                {
//                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//                    NSDictionary * dict = [defaults objectForKey:localKey];
//                    if(dict) {
//                        block(dict, true);
//                    } else {
//                        [NSThread sleepForTimeInterval:0.001];
//                        [self queryForInfo:block];
//                    }
//                    break;
//                }
//                default:
//                    [NSThread sleepForTimeInterval:0.001];
//                    [self queryForInfo:block];
//                    break;
//            }
//            break;
//        }
//    }
//}
