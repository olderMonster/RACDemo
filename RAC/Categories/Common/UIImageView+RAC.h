//
//  UIImageView+RAC.h
//  RAC
//
//  Created by 印聪 on 2018/9/12.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImageView (RAC)


/**
 根据url架子啊图片

 @param url 图片url
 */
- (void)rac_imageWithuUrl:(NSString *)url;


/**
 根据url加载圆形图片

 @param url 图片url
 */
- (void)rac_circleImageWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
