//
//  VideoViewModel.h
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoViewModel : NSObject

@property (nonatomic , strong)RACCommand *videosCommand;

@end

NS_ASSUME_NONNULL_END
