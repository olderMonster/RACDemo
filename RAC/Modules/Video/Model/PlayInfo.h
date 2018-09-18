//
//  PlayVideo.h
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayInfo : NSObject

@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *url;
@property (nonatomic , assign)NSInteger width;
@property (nonatomic , assign)NSInteger height;
@property (nonatomic , strong)NSArray *urlList;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (NSArray *)playInfoWithArray:(NSArray *)infos;

@end

NS_ASSUME_NONNULL_END
