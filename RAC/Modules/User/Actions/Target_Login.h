//
//  Target_Login.h
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Target_Login : NSObject

- (UIViewController *)Action_nativeFetchForgotPsdViewController:(NSDictionary *)params;
- (UIViewController *)Action_nativeFetchRegisterViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
