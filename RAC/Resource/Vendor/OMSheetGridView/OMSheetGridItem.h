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

- (instancetype)initWithTitle:(NSString *)title iconImage:(UIImage *)iconImage;

@end

NS_ASSUME_NONNULL_END
