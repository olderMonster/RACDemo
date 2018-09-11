//
//  OMDownloadService.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMDownloadService.h"



@interface OMDownloadService()<NSURLSessionDataDelegate>


@property (nonatomic , assign , readwrite)CGFloat progress;
@property (nonatomic , strong , readwrite)NSString *url;



@property (nonatomic , strong)NSURLSession *session;

@end

@implementation OMDownloadService



#pragma mark -- life cycle
- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

#pragma mark -- piublic method
- (void)download{
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:self.url]];
    [downloadTask resume];
    if (self.delegate && [self.delegate respondsToSelector:@selector(service:didStartDownloadFile:)]) {
        [self.delegate service:self didStartDownloadFile:self.url];
    }
}


#pragma mark -- NSURLSessionDataDelegate

/**
 写数据
 
 @param session 会话对象
 @param downloadTask 下载任务
 @param bytesWritten 本次写入的数据大小
 @param totalBytesWritten 下载的数据总大小
 @param totalBytesExpectedToWrite 文件总大小
*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progress = 1.0 * totalBytesWritten/totalBytesExpectedToWrite;
    if (self.delegate && [self.delegate respondsToSelector:@selector(service:shouldUpdateProgress:)]) {
        [self.delegate service:self shouldUpdateProgress:self.progress];
    }
}


/**
 当恢复下载的时候调用该方法
 
 @param fileOffset 从什么地方下载
 @param expectedTotalBytes 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);

}

/**
     当下载完成的时候调用
     
     @param location 文件的临时存储路径
*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(service:didDownloadedFile:)]) {
        [self.delegate service:self didDownloadedFile:fullPath];
    }
    
}


/**
 请求结束时调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"didCompleteWithError");
}


#pragma mark -- getters and setters
- (NSURLSession *)session{
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

@end
