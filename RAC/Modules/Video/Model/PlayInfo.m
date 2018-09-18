//
//  PlayVideo.m
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "PlayInfo.h"

@implementation PlayInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.type = dict[@"type"];
        self.url = dict[@"url"];
        self.width = [dict[@"width"] integerValue];
        self.height = [dict[@"height"] integerValue];
        self.urlList = dict[@"urlList"];
    }
    return self;
}
+ (NSArray *)playInfoWithArray:(NSArray *)infos{
    if (infos == nil || infos.count <= 0) {
        return nil;
    }
    NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in infos) {
        PlayInfo *info = [[PlayInfo alloc] initWithDict:dict];
        [tmpMArray addObject:info];
    }
    return tmpMArray.copy;
}


@end
