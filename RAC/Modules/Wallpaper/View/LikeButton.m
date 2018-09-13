//
//  LikeButton.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "LikeButton.h"

CGFloat const kLikeButtonCountFontSize = 13;
CGFloat const kLikeButtonImageSize = 17;

@implementation LikeButton

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat width = kLikeButtonImageSize;
    CGFloat height = width;
    CGFloat x = 5;
    CGFloat y = contentRect.size.height * 0.5 - height * 0.5;
    return CGRectMake(x, y, width, height);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = CGRectGetMaxX(self.imageView.frame) + 3;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}

@end
