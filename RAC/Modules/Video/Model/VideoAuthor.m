//
//  VideoAuthor.m
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "VideoAuthor.h"

@implementation VideoAuthor

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.aid = [dict[@"id"] integerValue];
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.desc = dict[@"description"];
        self.latestReleaseTime = [dict[@"latestReleaseTime"] doubleValue];
        self.videoNum = [dict[@"videoNum"] integerValue];
        self.follow_itemType = dict[@"follow"][@"itemType"];
        self.follow_itemId = [dict[@"follow"][@"itemId"] integerValue];
        self.follow_followed = [dict[@"follow"][@"followed"] boolValue];
        self.shield_itemType = dict[@"shield"][@"itemType"];
        self.shield_itemId = [dict[@"shield"][@"itemId"] integerValue];
        self.shield_shielded = [dict[@"shield"][@"shielded"] boolValue];
        self.approvedNotReadyVideoCount = [dict[@"approvedNotReadyVideoCount"] integerValue];
        self.ifPgc = [dict[@"ifPgc"] boolValue];
    }
    return self;
}

@end
