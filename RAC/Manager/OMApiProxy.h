//
//  OMApiProxy.h
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SucceedRequest)(NSDictionary *responseObject);
typedef void(^FailedRequest)(NSError *error);

@interface OMApiProxy : NSObject

@property (nonatomic , strong)NSArray *downloadTaskArray;


+ (instancetype)sharedInstance;

- (void)getUrlName:(NSString *)urlName
        paramaters:(NSDictionary *)paramaters
           success:(SucceedRequest)success
           failure:(FailedRequest)failure;

@end
