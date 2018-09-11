//
//  Wallpaper.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCategory.h"

@implementation WallPaperCategory


- (instancetype)initWithWallpaper:(NSDictionary *)category{
    self = [super init];
    if (self) {
        self.cid = category[@"id"];
        self.rname  = category[@"rname"];
        self.ename  = category[@"ename"];
        self.name  = category[@"name"];
        self.cover  = category[@"cover"];
        self.rank = [category[@"rank"] integerValue];
        self.count = [category[@"count"] integerValue];
    }
    return self;
}

@end
