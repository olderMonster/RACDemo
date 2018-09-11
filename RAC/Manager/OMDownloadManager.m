//
//  OMDownloadManager.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMDownloadManager.h"

#import <Photos/Photos.h>


static NSString *kDownloadTasksCacheKey = @"kTasksLocalCacheKey";

static OMDownloadManager *sharedInstance = nil;

@interface OMDownloadManager()<OMDownloadServiceDelegate>


@end

@implementation OMDownloadManager

#pragma mark -- life cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OMDownloadManager alloc] init];
    });
    return sharedInstance;
}


#pragma mark -- public method
- (void)download:(NSString *)url{
    OMDownloadService *service = [[OMDownloadService alloc] initWithUrl:url];
    service.delegate = self;
    [service download];
    [self.downloadProxyMArray addObject:service];
    
    [self cacheDownloadTasks];
}


#pragma mark -- private method
- (void)updateCache:(OMDownloadService *)downloadService{

    for (NSInteger index = 0; index < self.downloadProxyMArray.count; index++) {
        if ([self.downloadProxyMArray[index] isEqual:downloadService]) {
            self.downloadProxyMArray[index] = downloadService;
            break;
        }
    }
    
    [self cacheDownloadTasks];
}

- (void)cacheDownloadTasks{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.downloadProxyMArray options:NSJSONWritingPrettyPrinted error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kDownloadTasksCacheKey];
}

#pragma mark -- OMDownloadServiceDelegate
/**
 文件下载完成
 
 @param downloadService 当前任务
 @param fullPath 文件本地路径
 */
- (void)service:(OMDownloadService *)downloadService didDownloadedFile:(NSString *)fullPath{
    
//    UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        //写入图片到相册
//        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"保存失败 = %@",error);
//        }else{
//            NSLog(@"保存成功 = %d", success);
//        }
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        if ([fileManager fileExistsAtPath:fullPath]) {
//            NSError *error = nil;
//            [fileManager removeItemAtURL:[NSURL fileURLWithPath:fullPath] error:&error];
//            if (error) {
//                NSLog(@"移除本地下载图片失败");
//            }
//        }
//
//
//    }];
    
    //当下载任务完成后更新任务列表
    [self updateCache:downloadService];
}


#pragma mark -- getters and setters
- (NSMutableArray *)downloadProxyMArray{
    if (_downloadProxyMArray == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kDownloadTasksCacheKey];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _downloadProxyMArray = [[NSMutableArray alloc] initWithArray:array];
    }
    return _downloadProxyMArray;
}


@end
