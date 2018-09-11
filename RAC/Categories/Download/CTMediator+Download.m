//
//  CTMediator+Download.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "CTMediator+Download.h"


//这里的字符串是action中类的名称
NSString * const kCTMediatorTargetDownload = @"Download";

//这里的字符串时action中方法名
NSString * const kCTMediatorActionNativeFetchDownloadViewController = @"nativeFetchDownloadViewController";


@implementation CTMediator (Download)

- (UIViewController *)CTMediator_viewControllerForDownloadViewController{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetDownload
                                                    action:kCTMediatorActionNativeFetchDownloadViewController
                                                    params:nil
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        return vc;
    }
}

@end
