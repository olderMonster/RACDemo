//
//  WallPaper.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaper.h"

@implementation WallPaper

- (instancetype)initWithWallPaper:(NSDictionary *)wallpaper{
    self = [super init];
    if (self) {
        self.wid = wallpaper[@"id"];
        self.thumb = wallpaper[@"thumb"];
        self.img = wallpaper[@"img"];
        self.rank = [wallpaper[@"rank"] integerValue];
    }
    return self;
}

@end
