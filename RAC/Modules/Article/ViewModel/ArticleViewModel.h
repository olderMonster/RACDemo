//
//  ArticleViewModel.h
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , ArticleSourceType) {
    ArticleSourceTypeToday  = 0,  //今日美文
    ArticleSourceTypeDate   = 1,  //指定日期美文，日期格式yyyyMMdd
    ArticleSourceTypeRandom = 2   //随机美文
};

@interface ArticleViewModel : NSObject


//每日一文
@property (nonatomic , strong)RACCommand *articleCommand;


@property (nonatomic , strong)RACCommand *randomArticleCommand;

@end

NS_ASSUME_NONNULL_END
