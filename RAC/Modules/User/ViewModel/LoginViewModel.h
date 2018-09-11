//
//  LoginViewModel.h
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>

@interface LoginViewModel : NSObject

//验证手机号的信号
@property (nonatomic , strong)RACSignal *mobileSignal;
//验证密码的信号
@property (nonatomic , strong)RACSignal *passwordSignal;


//参数验证信号
@property (nonatomic , strong)RACSignal *paramsSignal;


//登录
@property (nonatomic , strong)RACCommand *loginCommand;

@end
