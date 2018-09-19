//
//  OMSheetGridItem.m
//  RAC
//
//  Created by 印聪 on 2018/9/18.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMSheetGridItem.h"

@implementation OMSheetGridItem

- (instancetype)initWithTitle:(NSString *)title iconImage:(UIImage *)iconImage{
    self = [super init];
    if (self) {
        self.title = title;
        self.iconImage = iconImage;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title iconImage:(UIImage *)iconImage type:(NSInteger)type{
    self = [super init];
    if (self) {
        self.title = title;
        self.iconImage = iconImage;
        self.type = type;
    }
    return self;
}

@end
