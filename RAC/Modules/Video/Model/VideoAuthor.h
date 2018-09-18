//
//  VideoAuthor.h
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoAuthor : NSObject

@property (nonatomic , assign)NSInteger aid;  //用户id

/**
 姓名
 */
@property (nonatomic , copy)NSString *name;


/**
 头像icon
 */
@property (nonatomic , copy)NSString *icon;

/**
 描述
 */
@property (nonatomic , copy)NSString *desc;
@property (nonatomic , assign)double latestReleaseTime;  //上次发布时间
@property (nonatomic , assign)NSInteger videoNum;  
@property (nonatomic , copy)NSString *follow_itemType;
@property (nonatomic , assign)NSInteger follow_itemId;
@property (nonatomic , assign)BOOL follow_followed;
@property (nonatomic , copy)NSString *shield_itemType;
@property (nonatomic , assign)NSInteger shield_itemId;
@property (nonatomic , assign)BOOL shield_shielded;
@property (nonatomic , assign)NSInteger approvedNotReadyVideoCount;
@property (nonatomic , assign)BOOL ifPgc;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
