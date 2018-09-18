//
//  Video.h
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , MediaType) {
    MediaTypeVideo = 0,          //视频
    MediaTypeVideoCollection = 1, //视频集合(关于主题的视频合集，比如美食)
    MediaTypeTextHeader = 2,
    MediaTypeTextFooter = 3,
};


@interface Media : NSObject

/**
 数据类型, video/videoCollectionWithCover/textHeader/textFooter
 VideoBeanForClient，为video
 ItemCollection，video的集合
 */
@property (nonatomic , assign)MediaType type;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)mediaWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
