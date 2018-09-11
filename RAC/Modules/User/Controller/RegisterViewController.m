//
//  RegisterViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "RegisterViewController.h"

#import "RegisterViewModel.h"

@interface RegisterViewController ()

//手机号
@property (nonatomic , strong)UITextField *mobileTextField;
//密码
@property (nonatomic , strong)UITextField *passwordTextField;
//确认密码
@property (nonatomic , strong)UITextField *ensurePsdTextField;
//验证码
@property (nonatomic , strong)UITextField *verifyCodeTextField;
//验证码按钮
@property (nonatomic , strong)UIButton *verifyCodeButton;
//注册按钮
@property (nonatomic , strong)UIButton *registerButton;

@property (nonatomic , strong)RegisterViewModel *registerViewModel;

//是否在倒计时中
@property (nonatomic , assign)BOOL countDown;

@end

@implementation RegisterViewController


#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.countDown = NO;
    
    [self.view addSubview:self.mobileTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.ensurePsdTextField];
    [self.view addSubview:self.verifyCodeTextField];
    [self.view addSubview:self.verifyCodeButton];
    [self.view addSubview:self.registerButton];
    
    [self bindViewModel];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.mobileTextField.frame = CGRectMake(20, 40 + 64, self.view.bounds.size.width - 40, 35);
    self.passwordTextField.frame = CGRectMake(20, CGRectGetMaxY(self.mobileTextField.frame) + 20, self.mobileTextField.bounds.size.width, self.mobileTextField.bounds.size.height);
    self.ensurePsdTextField.frame = CGRectMake(20, CGRectGetMaxY(self.passwordTextField.frame) + 20, self.mobileTextField.bounds.size.width, self.mobileTextField.bounds.size.height);
    
    CGFloat buttonW = 100;
    self.verifyCodeButton.frame = CGRectMake(CGRectGetMaxX(self.ensurePsdTextField.frame) - buttonW, CGRectGetMaxY(self.ensurePsdTextField.frame) + 20, buttonW, self.mobileTextField.bounds.size.height);
    self.verifyCodeTextField.frame = CGRectMake(20, self.verifyCodeButton.frame.origin.y, self.verifyCodeButton.frame.origin.x - 20 - 20, self.mobileTextField.bounds.size.height);
    self.registerButton.frame = CGRectMake(20, CGRectGetMaxY(self.verifyCodeTextField.frame) + 40, self.view.bounds.size.width - 40, 35);
}

#pragma mark -- private method
- (void)bindViewModel{
    
    RACSignal *mobileSignal = self.mobileTextField.rac_textSignal;
    RACSignal *passwordSignal = self.passwordTextField.rac_textSignal;
    RACSignal *ensurePsdSignal = self.ensurePsdTextField.rac_textSignal;
    RACSignal *verifyCodeSignal = self.verifyCodeTextField.rac_textSignal;

    
    self.registerViewModel.mobileSignal = mobileSignal;
    self.registerViewModel.passwordSignal = passwordSignal;
    self.registerViewModel.ensurePsdSignal = ensurePsdSignal;
    self.registerViewModel.verifyCodeSignal = verifyCodeSignal;
    
    //绑定注册
    RAC(self.registerButton,enabled) = self.registerViewModel.paramsSignal;
    //绑定获取验证码
//    RAC(self.verifyCodeButton,enabled) = self.registerViewModel.verifyCodeParamsSignal;
    
    RACSignal *paramsSignal = [[RACSignal combineLatest:@[mobileSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSString *mobile) = value;
        //@()将值变量装箱成对象
        NSNumber *num = @(mobile.length == 11 && !self.countDown);
        return num;
    }];
    RAC(self.verifyCodeButton, enabled) = paramsSignal;
    
    
    //监听注册按钮是否能够点击
    [RACObserve(self.registerButton, enabled) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            self.registerButton.backgroundColor = [UIColor greenColor];
        }else{
            self.registerButton.backgroundColor = [UIColor lightGrayColor];
        }
    }];
    
    //监听获取验证码按钮是否能够点击
    [RACObserve(self.verifyCodeButton, enabled) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            self.verifyCodeButton.backgroundColor = [UIColor greenColor];
        }else{
            self.verifyCodeButton.backgroundColor = [UIColor lightGrayColor];
        }
    }];

}


#pragma mark -- event response
- (void)verifyCodeAction{
    
    //写法2(常用写法)：
    [self.registerViewModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        NSLog(@"json = %@",x);
        
        __block NSInteger count = 60;
        self.countDown = YES;
        [[[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] take:count] subscribeNext:^(id x) {
            [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"%01ldS",count] forState:UIControlStateNormal];
            //放在块内执行，避免出现倒计时和按钮enabled变更不一致
            if (self.verifyCodeButton.enabled) {
                self.verifyCodeButton.enabled = NO;
            }
            
            count --;
            if (count == 0) {
                [self.verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.verifyCodeButton.enabled = YES;
                self.countDown = NO;
            }
          
        }];
        
    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.registerViewModel.registerCommand.errors subscribeNext:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    [self.registerViewModel.registerCommand execute:@{@"mobile":@"18701712551"}];
    
}


#pragma mark -- getters and setters
- (UITextField *)mobileTextField{
    if (_mobileTextField == nil) {
        _mobileTextField = [[UITextField alloc] init];
        _mobileTextField.placeholder = @"请输入手机号";
        _mobileTextField.font = [UIFont systemFontOfSize:14];
        _mobileTextField.layer.masksToBounds = YES;
        _mobileTextField.layer.cornerRadius = 3.0f;
        _mobileTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _mobileTextField.layer.borderWidth = 1.0f;
    }
    return _mobileTextField;
}

- (UITextField *)passwordTextField{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.font = [UIFont systemFontOfSize:14];
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.cornerRadius = 3.0f;
        _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _passwordTextField.layer.borderWidth = 1.0f;
    }
    return _passwordTextField;
}

- (UITextField *)ensurePsdTextField{
    if (_ensurePsdTextField == nil) {
        _ensurePsdTextField = [[UITextField alloc] init];
        _ensurePsdTextField.placeholder = @"请输入确认密码";
        _ensurePsdTextField.font = [UIFont systemFontOfSize:14];
        _ensurePsdTextField.layer.masksToBounds = YES;
        _ensurePsdTextField.layer.cornerRadius = 3.0f;
        _ensurePsdTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _ensurePsdTextField.layer.borderWidth = 1.0f;
    }
    return _ensurePsdTextField;
}

- (UITextField *)verifyCodeTextField{
    if (_verifyCodeTextField == nil) {
        _verifyCodeTextField = [[UITextField alloc] init];
        _verifyCodeTextField.placeholder = @"请输入验证码";
        _verifyCodeTextField.font = [UIFont systemFontOfSize:14];
        _verifyCodeTextField.layer.masksToBounds = YES;
        _verifyCodeTextField.layer.cornerRadius = 3.0f;
        _verifyCodeTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _verifyCodeTextField.layer.borderWidth = 1.0f;
    }
    return _verifyCodeTextField;
}

- (UIButton *)verifyCodeButton{
    if (_verifyCodeButton == nil) {
        _verifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _verifyCodeButton.backgroundColor = [UIColor lightGrayColor];
        _verifyCodeButton.layer.masksToBounds = YES;
        _verifyCodeButton.layer.cornerRadius = 3.0f;
        _verifyCodeButton.layer.borderColor = [UIColor grayColor].CGColor;
        _verifyCodeButton.layer.borderWidth = 1.0f;
        [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_verifyCodeButton addTarget:self action:@selector(verifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyCodeButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor lightGrayColor];
        [_registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 3.0f;
    }
    return _registerButton;
}

- (RegisterViewModel *)registerViewModel{
    if (_registerViewModel == nil) {
        _registerViewModel = [[RegisterViewModel alloc] init];
    }
    return _registerViewModel;
}

@end
