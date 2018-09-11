//
//  UserViewController.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "UserViewController.h"

#import "LoginViewController.h"

@interface UserViewController ()

@property (nonatomic , strong)UIButton *loginButton;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loginButton];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.loginButton.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 20,64 + 40, 60, 30);
    self.loginButton.layer.masksToBounds = self.loginButton.bounds.size.height * 0.5;
}


#pragma mark -- event response
- (void)presentLoginVCAction{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark -- getters and setters
- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _loginButton.layer.borderWidth = 1.0f;
        [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton addTarget:self action:@selector(presentLoginVCAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
