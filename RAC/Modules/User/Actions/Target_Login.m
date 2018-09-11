//
//  Target_Login.m
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Target_Login.h"

#import "ForgotPsdViewController.h"
#import "RegisterViewController.h"

@implementation Target_Login


// 因为action是从属于Module的，所以action直接可以使用ModuleA里的所有声明
- (UIViewController *)Action_nativeFetchForgotPsdViewController:(NSDictionary *)params{
    ForgotPsdViewController *forgotPsdVC = [[ForgotPsdViewController alloc] init];
    return forgotPsdVC;
}

- (UIViewController *)Action_nativeFetchRegisterViewController:(NSDictionary *)params{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    return registerVC;
}

@end
