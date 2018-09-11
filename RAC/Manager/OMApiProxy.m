//
//  OMApiProxy.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMApiProxy.h"

#import <AFNetworking/AFNetworking.h>

static OMApiProxy *sharedInstance = nil;

@interface OMApiProxy()

@property (nonatomic , strong)AFHTTPSessionManager *sessionManager;

@property (nonatomic , strong)NSString *baseURL;

@end


@implementation OMApiProxy


#pragma mark -- life cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OMApiProxy alloc] init];
    });
    return sharedInstance;
}


#pragma mark -- public method
- (void)getUrlName:(NSString *)urlName paramaters:(NSDictionary *)paramaters success:(SucceedRequest)success failure:(FailedRequest)failure{
    
    
    if (urlName) {
        [self.sessionManager GET:urlName parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success?success(responseObject):nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure?failure(error):nil;
        }];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success(@{@"code":@"100200",@"data":@"",@"message":@""});
        });
    }
}

- (void)downFile:(NSString *)url{
    
}


#pragma mark -- getters and setters
- (AFHTTPSessionManager *)sessionManager{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 10.0;
    }
    return _sessionManager;
}

@end
