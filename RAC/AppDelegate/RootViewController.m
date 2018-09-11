//
//  RootViewController.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "RootViewController.h"

#import "HomeViewController.h"
#import "UserViewController.h"

#import "CTMediator+WallPaper.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *appearceBar = [UINavigationBar appearance];
    [appearceBar setBarTintColor:[UIColor lightGrayColor]];
    [appearceBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homaNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homaNav.tabBarItem.title = @"首页";
    
    UIViewController *wallpaperCategoryVC = [[CTMediator sharedInstance] CTMediator_viewControllerForWallPaperCategoryViewController];
    UINavigationController *wallpaperNav = [[UINavigationController alloc] initWithRootViewController:wallpaperCategoryVC];
    wallpaperNav.tabBarItem.title = @"壁纸";
    
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
    userNav.tabBarItem.title = @"我的";
    
    self.viewControllers = @[homaNav,wallpaperNav,userNav];
    
}


@end
