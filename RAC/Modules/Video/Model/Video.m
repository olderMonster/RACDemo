//
//  Video.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Video.h"

#import "DateFormatterManager.h"

@interface Video()

@property (nonatomic , copy , readwrite)NSString *releaseTimeStr;

@end

@implementation Video

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.dataType = dict[@"dataType"];
        
        self.vid = [dict[@"id"] integerValue];
        self.title = dict[@"title"];
        self.desc = dict[@"description"];
        self.library = dict[@"library"];
        self.tags = [VideoTag tagsWithArray:dict[@"tags"]];
        self.collectionCount = [dict[@"consumption"][@"collectionCount"] integerValue];
        self.shareCount = [dict[@"consumption"][@"shareCount"] integerValue];
        self.replyCount = [dict[@"consumption"][@"replyCount"] integerValue];
        self.resourceType = dict[@"resourceType"];
        self.slogan = dict[@"slogan"];
        self.provider_name = dict[@"provider"][@"name"];
        self.provider_alias = dict[@"provider"][@"alias"];
        self.provider_icon = dict[@"provider"][@"icon"];
        self.category = dict[@"category"];
        self.author = [[VideoAuthor alloc] initWithDict:dict[@"author"]];
        self.cover_feed = dict[@"cover"][@"feed"];
        self.cover_detail = dict[@"cover"][@"detail"];
        self.cover_blurred = dict[@"cover"][@"blurred"];
        self.cover_homepage = dict[@"cover"][@"homepage"];
        self.playUrl = dict[@"playUrl"];
        self.duration = [dict[@"duration"] doubleValue];
        self.releaseTime = [dict[@"releaseTime"] doubleValue];
        self.releaseTimeStr = [[DateFormatterManager sharedInstance] releaseTime:self.releaseTime];
        self.playInfos = [PlayInfo playInfoWithArray:dict[@"playInfo"]];
        self.ifLimitVideo = [dict[@"ifLimitVideo"] boolValue];
        self.searchWeight = [dict[@"searchWeight"] boolValue];
        self.idx = [dict[@"idx"] integerValue];
        self.date = [dict[@"date"] doubleValue];
        self.descriptionEditor = dict[@"descriptionEditor"];
        self.collected = [dict[@"collected"] doubleValue];
        self.played = [dict[@"played"] doubleValue];
    }
    return self;
}

@end
