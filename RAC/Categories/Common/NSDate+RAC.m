//
//  NSDate+RAC.m
//  RAC
//
//  Created by 印聪 on 2018/9/12.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "NSDate+RAC.h"

@implementation NSDate (RAC)

/**
 
 *  是否为今年
 
 */

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

@end
