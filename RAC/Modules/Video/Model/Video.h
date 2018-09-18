//
//  Video.h
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"
#import "VideoTag.h"
#import "VideoAuthor.h"
#import "PlayInfo.h"
NS_ASSUME_NONNULL_BEGIN


@interface Video : Media

@property (nonatomic , copy)NSString *dataType;
@property (nonatomic , assign)NSInteger vid;   //视频 id
@property (nonatomic , copy)NSString *title;  //标题
@property (nonatomic , copy)NSString *desc; //简易描述
@property (nonatomic , copy)NSString *library;
@property (nonatomic , copy)NSString *resourceType;

//视频标签
@property (nonatomic , strong)NSArray <VideoTag *>*tags;

@property (nonatomic , assign)NSInteger collectionCount;  //收藏数
@property (nonatomic , assign)NSInteger shareCount;      //分享数
@property (nonatomic , assign)NSInteger replyCount;      //回复数

//内容提供商
@property (nonatomic , copy)NSString *provider_name;
@property (nonatomic , copy)NSString *provider_alias;
@property (nonatomic , copy)NSString *provider_icon;

@property (nonatomic , copy)NSString *slogan;  //一句箴言
@property (nonatomic , copy)NSString *category;  //分类

@property (nonatomic , strong)VideoAuthor *author;

//封面
@property (nonatomic , copy)NSString *cover_feed;
@property (nonatomic , copy)NSString *cover_detail;
@property (nonatomic , copy)NSString *cover_blurred;
@property (nonatomic , copy)NSString *cover_homepage;

@property (nonatomic , copy)NSString *playUrl;   //视频播放地址
@property (nonatomic , assign)double duration; //播放时长

//网页链接
@property (nonatomic , copy)NSString *webUrl_raw;
@property (nonatomic , copy)NSString *webUrl_forWeibo;

@property (nonatomic , assign)double releaseTime; //发布时间
@property (nonatomic , copy , readonly)NSString *releaseTimeStr;

@property (nonatomic , strong)NSArray <PlayInfo *> *playInfos;

@property (nonatomic , copy)NSString *descriptionEditor; //影评(好像是)

@property (nonatomic , assign)BOOL ifLimitVideo;
@property (nonatomic , assign)BOOL searchWeight;
@property (nonatomic , assign)NSInteger idx;
@property (nonatomic , assign)double date;
@property (nonatomic , assign)BOOL collected;

@property (nonatomic , assign)BOOL played;

/***************************************** VideoDataTypeVideo  ********************************************/



- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
