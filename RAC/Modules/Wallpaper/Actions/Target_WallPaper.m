//
//  Action_WallPaper.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Target_WallPaper.h"

#import "WallPaperCategoryViewController.h"
#import "WallPaperViewController.h"
#import "WallPaperCommentViewController.h"

@implementation Target_WallPaper

- (UIViewController *)Action_nativeFetchWallPaperCategoryViewController:(NSDictionary *)params{
    WallPaperCategoryViewController *downloadVC = [[WallPaperCategoryViewController alloc] init];
    return downloadVC;
}

- (UIViewController *)Action_nativeFetchWallPaperViewController:(NSDictionary *)params{
    WallPaperViewController *wallpaperVC = [[WallPaperViewController alloc] init];
    wallpaperVC.categoryId = params[@"categoryId"];
    return wallpaperVC;
}

- (UIViewController *)Action_nativeFetchWallPaperCommentViewController:(NSDictionary *)params{
    WallPaperCommentViewController *commentVC = [[WallPaperCommentViewController alloc] init];
    commentVC.wallpaperId = params[@"wallpaperId"];
    return commentVC;
}

@end
