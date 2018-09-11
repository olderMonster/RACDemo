//
//  LoginViewController.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginViewModel.h"

#import "CTMediator+Login.h"

@interface LoginViewController ()

//手机号输入框
@property (nonatomic , strong)UITextField *mobileTextField;
//密码输入框
@property (nonatomic , strong)UITextField *passwordTextField;
//忘记密码
@property (nonatomic , strong)UIButton *forgotPsdButton;
//登录按钮
@property (nonatomic , strong)UIButton *loginButton;
//注册按钮
@property (nonatomic , strong)UIButton *registerButton;


@property (nonatomic , strong)LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mobileTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.forgotPsdButton];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    
    [self bindViewModel];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.mobileTextField.frame = CGRectMake(20, 40 + 64, self.view.bounds.size.width - 40, 35);
    self.passwordTextField.frame = CGRectMake(20,CGRectGetMaxY(self.mobileTextField.frame) + 20 , self.view.bounds.size.width - 40, 35);
    CGSize forgotPsdSize = [self.forgotPsdButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.forgotPsdButton.titleLabel.font}];
    self.forgotPsdButton.frame = CGRectMake(CGRectGetMaxX(self.passwordTextField.frame) - forgotPsdSize.width, CGRectGetMaxY(self.passwordTextField.frame) + 10, forgotPsdSize.width, forgotPsdSize.height);
    
    self.loginButton.frame = CGRectMake(20, CGRectGetMaxY(self.forgotPsdButton.frame) + 40, self.view.bounds.size.width - 40, 40);
    
    CGSize registerSize = [self.registerButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.forgotPsdButton.titleLabel.font}];
    self.registerButton.bounds = CGRectMake(0, 0, registerSize.width, registerSize.height);
    self.registerButton.center = CGPointMake(self.view.bounds.size.width * 0.5, CGRectGetMaxY(self.loginButton.frame) + 30);
}


#pragma mark -- private method
- (void)setupNavigationItems{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton setTitle:@"取消" forState:UIControlStateNormal];
    dismissButton.frame = CGRectMake(0, 0, 40, 30);
    dismissButton.titleLabel.font = [UIFont systemFontOfSize:12];
    UIBarButtonItem *dismissItem = [[UIBarButtonItem alloc] initWithCustomView:dismissButton];
    self.navigationItem.rightBarButtonItem = dismissItem;
    
    [[dismissButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)bindViewModel{
    
    /*
     将TextField的输入转化为信号量
     */
    RACSignal *mobileSignal = self.mobileTextField.rac_textSignal;
    RACSignal *psdSignal = self.passwordTextField.rac_textSignal;
    /*
     合并两个输入框的信号量，并使用map对信号量返回值进行映射使其返回bool值，
     */
//    RACSignal *paramsSignal = [[RACSignal combineLatest:@[mobileSignal,psdSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
//        RACTupleUnpack(NSString *username , NSString *psd) = value;
//        //@()将值变量装箱成对象
//        NSNumber *num = @([username length] == 11 && [psd length] >= 6);
//        NSLog(@"num = %@",num);
//        return num;
//    }];
//    /*
//     使用RAC将一个信号量绑定在一个属性上
//     */
//    RAC(self.loginButton, enabled) = paramsSignal;
    

    self.loginViewModel.mobileSignal = mobileSignal;
    self.loginViewModel.passwordSignal = psdSignal;
    RAC(self.loginButton, enabled) = self.loginViewModel.paramsSignal;

    [RACObserve(self.loginButton, enabled) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            self.loginButton.backgroundColor = [UIColor greenColor];
        }else{
            self.loginButton.backgroundColor = [UIColor lightGrayColor];
        }
    }];

    
    //忘记密码点击事件
    [[self.forgotPsdButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ){
        UIViewController *forgotVC = [[CTMediator sharedInstance] CTMediator_viewControllerForForgotViewController];
        [self.navigationController pushViewController:forgotVC animated:YES];
    }];
}


#pragma mark -- event response
- (void)loginAction{
    
    //进行登录操作
    //写法1：
//    [self.loginViewModel.loginCommand.executionSignals subscribeNext:^(RACSignal * _Nullable execution) {
//
//        [execution subscribeNext:^(id x) {
//            //x为网络请求的回调结果,可以在这里对数据进行处理
//            NSLog(@"json = %@",x);
//        }];
//
//    }];
    
    
    
    //写法2(常用写法)：
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        NSLog(@"json = %@",x);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.loginViewModel.loginCommand.errors subscribeNext:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    [self.loginViewModel.loginCommand execute:@{@"mobile":@"18701712551",@"password":@"123456"}];
    
}


- (void)registerAction{
    UIViewController *registerVC = [[CTMediator sharedInstance] CTMediator_viewControllerForRegisterViewController];
    [self.navigationController pushViewController:registerVC animated:YES];
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

- (UIButton *)forgotPsdButton{
    if (_forgotPsdButton == nil) {
        _forgotPsdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgotPsdButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgotPsdButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _forgotPsdButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _forgotPsdButton;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor lightGrayColor];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 3.0f;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"还没有账号？前往注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (LoginViewModel *)loginViewModel{
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

@end
