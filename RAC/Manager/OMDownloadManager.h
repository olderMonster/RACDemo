//
//  OMDownloadManager.h
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMDownloadService.h"

NS_ASSUME_NONNULL_BEGIN


@interface OMDownloadManager : NSObject

@property (nonatomic , strong)NSMutableArray *downloadProxyMArray;

+ (instancetype)sharedInstance;
- (void)download:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
