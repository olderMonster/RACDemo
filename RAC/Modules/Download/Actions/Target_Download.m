//
//  Target_Download.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Target_Download.h"

#import "DownloadViewController.h"

@implementation Target_Download

- (UIViewController *)Action_nativeFetchDownloadViewController:(NSDictionary *)params{
    DownloadViewController *downloadVC = [[DownloadViewController alloc] init];
    return downloadVC;
}

@end
