//
//  UIImageView+RAC.m
//  RAC
//
//  Created by 印聪 on 2018/9/12.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "UIImageView+RAC.h"

#import "UIImage+RAC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (RAC)

- (void)rac_imageWithuUrl:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}


- (void)rac_circleImageWithUrl:(NSString *)url{
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            self.image = [UIImage imageWithClipImage:image];
        }
    }];
    
}

@end
