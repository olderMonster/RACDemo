//
//  VideoViewModel.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "VideoViewModel.h"

#import "OMApiProxy.h"

@implementation VideoViewModel

- (RACCommand *)videosCommand{
    if (_videosCommand == nil) {
        _videosCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *url = @"http://baobab.kaiyanapp.com/api/v4/tabs/selected";
                
                [[OMApiProxy sharedInstance] getUrlName:url paramaters:nil success:^(NSDictionary *responseObject) {
                    NSArray *itemList = responseObject[@"itemList"];
                    [subscriber sendNext:itemList];
                    //一定要加上sendCompleted这个方法,不然无法再次执行该command
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return  nil;
            }];
        }];
    }
    return _videosCommand;
}


@end
