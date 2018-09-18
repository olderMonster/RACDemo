//
//  ArticleViewModel.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "ArticleViewModel.h"
#import "OMApiProxy.h"

@implementation ArticleViewModel


- (RACCommand *)articleCommand{
    if (_articleCommand == nil) {
        _articleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                //默认为今天的文章
                NSString *url = @"https://interface.meiriyiwen.com/article/today?dev=1";
                
                NSInteger articleSourceType = [input[@"type"] integerValue];
                if (articleSourceType == ArticleSourceTypeRandom) {
                    //随机文章
                    url = @"https://interface.meiriyiwen.com/article/random?dev=1";
                }
                
                //指定日期文章
                if (articleSourceType == ArticleSourceTypeDate) {
                    url = [NSString stringWithFormat:@"https://interface.meiriyiwen.com/article/day?dev=1&date=%@",input[@"date"]];
                }
                
                
                [[OMApiProxy sharedInstance] getUrlName:url paramaters:nil success:^(NSDictionary *responseObject) {
                    NSInteger code = [responseObject[@"code"] integerValue];
                    if (code == 0) {
                        NSDictionary *data = responseObject[@"data"];
                        [subscriber sendNext:data];
                        //一定要加上sendCompleted这个方法,不然无法再次执行该command
                        [subscriber sendCompleted];
                    }else{
                        //一定要加上sendCompleted这个方法,不然无法再次执行该command
                        [subscriber sendError:nil];
                    }
                    
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return  nil;
            }];
        }];
    }
    return _articleCommand;
}




@end
