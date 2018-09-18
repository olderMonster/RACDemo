//
//  DateFormatterManager.m
//  RAC
//
//  Created by 印聪 on 2018/9/12.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "DateFormatterManager.h"

#import "NSDate+RAC.h"

static DateFormatterManager *sharedInstance = nil;

@interface DateFormatterManager()

@property (nonatomic , strong)NSDateFormatter *dateFormatter;

@end

@implementation DateFormatterManager

#pragma mark -- life cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DateFormatterManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark -- public method
- (NSString *)createAt:(double)timeInterval{
    double nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    double interval = nowTimeInterval - timeInterval;
    if (interval < 60) {
        return @"刚刚";
    }else if (interval < (60 * 60)){
        return [NSString stringWithFormat:@"%.f分钟前",interval/(60 * 60)];
    }else if (interval < (60 * 60 * 24)){
        return [NSString stringWithFormat:@"%.f小时前",interval/(60 * 60 * 24)];
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSString *createAt = nil;
        if ([date isThisYear]) {
            //今年的时间就只显示年月时分
            self.dateFormatter.dateFormat = @"MM-dd HH:ss";
            createAt = [self.dateFormatter stringFromDate:date];
        }else{
            //去年的时间就显示
            self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:ss";
            createAt = [self.dateFormatter stringFromDate:date];
        }
        return createAt;
    }
    
}

- (NSString *)releaseTime:(double)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    self.dateFormatter.dateFormat = @"yyyy年MM月dd日 HH时mm分";
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    return dateStr;
}


#pragma mark -- getters and setters
- (NSDateFormatter *)dateFormatter{
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}


@end
