//
//  VideoTag.h
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTag : NSObject

@property (nonatomic , assign)NSInteger tid;  //分类的 id
@property (nonatomic , copy)NSString *name;  //分类的名称
@property (nonatomic , copy)NSString *actionUrl; //分类的 url
@property (nonatomic , copy)NSString *bgPicture;
@property (nonatomic , copy)NSString *headerImage;
@property (nonatomic , copy)NSString *tagRecType;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)tagsWithArray:(NSArray *)tagsArray;

@end

NS_ASSUME_NONNULL_END
