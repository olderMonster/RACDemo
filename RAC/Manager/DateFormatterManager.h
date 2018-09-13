//
//  DateFormatterManager.h
//  RAC
//
//  Created by 印聪 on 2018/9/12.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateFormatterManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)createAt:(double)timeInterval;

@end

NS_ASSUME_NONNULL_END
