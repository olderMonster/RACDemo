//
//  UIColor+TTP.h
//  Animation3D
//
//  Created by 印聪 on 2018/9/4.
//  Copyright © 2018年 Ttpai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RAC)


/**
 十六进制颜色转换UIColor

 @param hex 十六进制颜色字符串
 @param alpha 透明度
 @return UIColor颜色对象
 */
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;


/**
 十六进制颜色转换UIColor

 @param hex 十六进制颜色字符串
 @return UIColor颜色对象
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
