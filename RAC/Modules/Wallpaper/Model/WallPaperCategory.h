//
//  Wallpaper.h
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 
 "count": 50741,
 "ename": "girl",
 "rname": "美女",
 "cover_temp": "56a964df69401b2866828acb",
 "name": "美女",
 "cover": "http://img5.adesk.com/5b88d73ce7bce737843362c5?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480",
 "rank": 1,
 "filter": [],
 "sn": 1,
 "icover": "582c34f869401b347e0b43fb",
 "atime": 1291266021,
 "type": 1,
 "id": "4e4d610cdf714d2966000000",
 "picasso_cover": "5b88d73ce7bce737843362c5"
 
 **/


@interface WallPaperCategory : NSObject

@property (nonatomic , copy)NSString *cid;
@property (nonatomic , copy)NSString *rname;
@property (nonatomic , copy)NSString *ename;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *cover;
@property (nonatomic , assign)NSInteger rank;
@property (nonatomic , assign)NSInteger count;

- (instancetype)initWithWallpaper:(NSDictionary *)category;

@end

NS_ASSUME_NONNULL_END
