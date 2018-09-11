//
//  CTMediator+Login.h
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (Login)

- (UIViewController *)CTMediator_viewControllerForForgotViewController;
- (UIViewController *)CTMediator_viewControllerForRegisterViewController;

@end

NS_ASSUME_NONNULL_END
