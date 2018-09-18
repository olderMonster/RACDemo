//
//  RootViewController.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "RootViewController.h"

#import "ArticleViewController.h"
#import "UserViewController.h"

#import "CTMediator+WallPaper.h"
#import "CTMediator+Article.h"
#import "CTMediator+Video.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *appearceBar = [UINavigationBar appearance];
    [appearceBar setBarTintColor:[UIColor lightGrayColor]];
    [appearceBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIViewController *articleVC = [[CTMediator sharedInstance] CTMediator_viewControllerForArticleViewController];
    UINavigationController *articleNav = [[UINavigationController alloc] initWithRootViewController:articleVC];
    articleNav.tabBarItem.title = @"美文";
    
    UIViewController *videoVC = [[CTMediator sharedInstance] CTMediator_viewControllerForVideoViewController];
    UINavigationController *videoNav = [[UINavigationController alloc] initWithRootViewController:videoVC];
    videoNav.tabBarItem.title = @"视频";
    
    UIViewController *wallpaperCategoryVC = [[CTMediator sharedInstance] CTMediator_viewControllerForWallPaperCategoryViewController];
    UINavigationController *wallpaperNav = [[UINavigationController alloc] initWithRootViewController:wallpaperCategoryVC];
    wallpaperNav.tabBarItem.title = @"壁纸";
    
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
    userNav.tabBarItem.title = @"我的";
    
    self.viewControllers = @[articleNav,videoNav,wallpaperNav,userNav];
    
}


@end
