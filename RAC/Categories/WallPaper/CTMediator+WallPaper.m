//
//  CTMediator+WallPaper.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "CTMediator+WallPaper.h"


//这里的f字符串是action中类的名称
NSString * const kCTMediatorTargetWallPaper = @"WallPaper";

//这里的字符串时action中方法名
NSString * const kCTMediatorActionNativeFetchWallPaperCategoryViewController = @"nativeFetchWallPaperCategoryViewController";
NSString * const kCTMediatorActionNativeFetchWallPaperViewController = @"nativeFetchWallPaperViewController";

@implementation CTMediator (WallPaper)

- (UIViewController *)CTMediator_viewControllerForWallPaperCategoryViewController{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetWallPaper
                                                    action:kCTMediatorActionNativeFetchWallPaperCategoryViewController
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

- (UIViewController *)CTMediator_viewControllerForWallPaperViewController:(NSDictionary *)params{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetWallPaper
                                                    action:kCTMediatorActionNativeFetchWallPaperViewController
                                                    params:params
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
