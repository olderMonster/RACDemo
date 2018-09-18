//
//  CTMediator+Article.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "CTMediator+Video.h"


//这里的f字符串是action中类的名称
NSString * const kCTMediatorTargetVideo = @"Video";
//这里的字符串时action中方法名
NSString * const kCTMediatorActionNativeFetchVideoViewController = @"nativeFetchVideoViewController";

@implementation CTMediator (Video)

- (UIViewController *)CTMediator_viewControllerForVideoViewController{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetVideo
                                                    action:kCTMediatorActionNativeFetchVideoViewController
                                                    params:nil
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}


@end
