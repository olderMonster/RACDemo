//
//  OMDownloadService.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class OMDownloadService;
NS_ASSUME_NONNULL_BEGIN

@protocol OMDownloadServiceDelegate <NSObject>

@optional;


/**
 开启下载任务

 @param downloadService 当前任务
 @param url 下载任务的url
 */
- (void)service:(OMDownloadService *)downloadService didStartDownloadFile:(NSString *)url;


/**
 任务下载进度

 @param downloadService 当前任务
 @param progress 下载进度
 */
- (void)service:(OMDownloadService *)downloadService shouldUpdateProgress:(CGFloat)progress;


/**
 文件下载完成

 @param downloadService 当前任务
 @param fullPath 文件本地路径
 */
- (void)service:(OMDownloadService *)downloadService didDownloadedFile:(NSString *)fullPath;

@end


@interface OMDownloadService : NSObject



/**
 下载资源的url
 */
@property (nonatomic , strong , readonly)NSString *url;


/**
 下载进度
 */
@property (nonatomic , assign , readonly)CGFloat progress;



/**
 代理，获取下载进度等
 */
@property (nonatomic , weak)id<OMDownloadServiceDelegate>delegate;

- (instancetype)initWithUrl:(NSString *)url;

- (void)download;

@end

NS_ASSUME_NONNULL_END
