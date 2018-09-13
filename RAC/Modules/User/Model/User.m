//
//  User.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.uid = dict[@"id"];
        self.name = dict[@"name"];
        self.avatar = dict[@"avatar"];
        self.follower = [dict[@"follower"] integerValue];
        self.following = [dict[@"following"] integerValue];
        self.gender = [dict[@"gender"] integerValue];
        self.isvip = [dict[@"isvip"] boolValue];
        if ([dict.allKeys containsObject:@"viptime"]) {
            self.viptime = [dict[@"viptime"] doubleValue];
        }
        
    }
    return self;
}

@end
