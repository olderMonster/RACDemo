//
//  Action_Video.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Target_Video.h"
#import "VideoViewController.h"
@implementation Target_Video

- (UIViewController *)Action_nativeFetchVideoViewController:(NSDictionary *)params{
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    return videoVC;
}

@end
