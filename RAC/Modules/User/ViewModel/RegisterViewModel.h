//
//  RegisterViewModel.h
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewModel : NSObject

//验证手机号的信号
@property (nonatomic , strong)RACSignal *mobileSignal;
//验证密码的信号
@property (nonatomic , strong)RACSignal *passwordSignal;
//确认密码
@property (nonatomic , strong)RACSignal *ensurePsdSignal;
//验证码
@property (nonatomic , strong)RACSignal *verifyCodeSignal;


//参数验证信号
@property (nonatomic , strong)RACSignal *paramsSignal;

//@property (nonatomic , strong)RACSignal *verifyCodeParamsSignal;

//获取验证码
@property (nonatomic , strong)RACCommand *verifyCodeCommand;
//注册
@property (nonatomic , strong)RACCommand *registerCommand;

@end

NS_ASSUME_NONNULL_END
