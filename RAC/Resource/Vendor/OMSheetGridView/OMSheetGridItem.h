//
//  OMSheetGridItem.h
//  RAC
//
//  Created by 印聪 on 2018/9/18.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface OMSheetGridItem : NSObject

@property (nonatomic , strong)NSString *title;
@property (nonatomic , strong)UIImage *iconImage;


/**
 当前item的类型。比如这边定义分享平台，那么可以z自己定义枚举，然后将type设为枚举值。这样在点击事件的回调处理中可以直接根据该值去判断
 */
@property (nonatomic , assign)NSInteger type;

- (instancetype)initWithTitle:(NSString *)title iconImage:(UIImage *)iconImage;

- (instancetype)initWithTitle:(NSString *)title iconImage:(UIImage *)iconImage type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
