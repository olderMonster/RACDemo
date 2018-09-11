//
//  WallpaperViewModel.h
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallPaperViewModel : NSObject

@property (nonatomic , strong)RACCommand *categoryCommand;

@property (nonatomic , strong)RACCommand *listCommand;

//@property (nonatomic , strong)RACCommand *downloadCommand;

@end

NS_ASSUME_NONNULL_END
