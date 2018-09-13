//
//  WallPaper.h
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 
 "views": 0,
 "ncos": 0,
 "rank": 35,
 "tag": [],
 "wp": "http://img5.adesk.com/5b0cefdce7bce735ab45d5c1",
 "xr": false,
 "cr": false,
 "favs": 1,
 "atime": 1536564003,
 "id": "5b0cefdce7bce735ab45d5c1",
 "desc": "",
 "thumb": "http://img5.adesk.com/5b0cefdce7bce735ab45d5c1?imageMogr2/thumbnail/!350x540r/gravity/Center/crop/350x540",
 "img": "http://img5.adesk.com/5b0cefdce7bce735ab45d5c1?imageMogr2/thumbnail/!720x1280r/gravity/Center/crop/720x1280",
 "cid": [
 "4e4d610cdf714d2966000003"
 ],
 "url": [],
 "rule": "?imageMogr2/thumbnail/!$<Width>x$<Height>r/gravity/Center/crop/$<Width>x$<Height>",
 "preview": "http://img5.adesk.com/5b0cefdce7bce735ab45d5c1",
 "store": "qiniu"
 
 **/


@interface WallPaper : NSObject

@property (nonatomic , copy)NSString *wid;
@property (nonatomic , copy)NSString *thumb;
@property (nonatomic , copy)NSString *img;
@property (nonatomic , assign)NSInteger rank;  //点赞数
@property (nonatomic , assign)NSInteger favs;  //收藏数
@property (nonatomic , copy)NSString *wp; //手机版下载地址

- (instancetype)initWithWallPaper:(NSDictionary *)wallpaperl;

@end

NS_ASSUME_NONNULL_END
