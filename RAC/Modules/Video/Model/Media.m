//
//  Video.m
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Media.h"

#import "Video.h"

@implementation Media

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        NSString *type = dict[@"type"];
        NSDictionary *data = dict[@"data"];
        if ([type isEqualToString:@"video"]) {
            self.type = MediaTypeVideo;
            self = [[Video alloc] initWithDict:data];
        }else if ([type isEqualToString:@"videoCollectionWithCover"]){
            self.type = MediaTypeVideoCollection;
        }else if ([type isEqualToString:@"textHeader"]){
            self.type = MediaTypeTextHeader;
        }else{
            self.type = MediaTypeTextFooter;
        }
    }
    return self;
}
+ (instancetype)mediaWithDict:(NSDictionary *)dict{
    NSString *type = dict[@"type"];
    NSDictionary *data = dict[@"data"];
    if ([type isEqualToString:@"video"]) {
        Video *video = [[Video alloc] initWithDict:data];
        video.type = MediaTypeVideo;
        return video;
    }else if ([type isEqualToString:@"videoCollectionWithCover"]){
        Media *media = [[Media alloc] init];
        media.type = MediaTypeVideoCollection;
        return media;
    }else if ([type isEqualToString:@"textHeader"]){
        Media *media = [[Media alloc] init];
        media.type = MediaTypeTextHeader;
        return media;
    }else{
        Media *media = [[Media alloc] init];
        media.type = MediaTypeTextFooter;
        return media;
    }
}


@end
