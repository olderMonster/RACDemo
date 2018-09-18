//
//  VideoTag.m
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "VideoTag.h"

@implementation VideoTag


- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.tid = [dict[@"id"] integerValue];
        self.name = dict[@"name"];
        self.actionUrl = dict[@"actionUrl"];
        self.bgPicture = dict[@"bgPicture"];
        self.headerImage = dict[@"headerImage"];
        self.tagRecType = dict[@"tagRecType"];
    }
    return self;
}


+ (NSArray *)tagsWithArray:(NSArray *)tagsArray{
    if (tagsArray == nil || tagsArray.count <= 0) {
        return nil;
    }
    NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in tagsArray) {
        VideoTag *tag = [[VideoTag alloc] initWithDict:dict];
        [tmpMArray addObject:tag];
    }
    return tmpMArray.copy;
}

@end
