//
//  WallpaperViewModel.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperViewModel.h"

#import "OMApiProxy.h"


@interface WallPaperViewModel()

@property (nonatomic , assign)NSInteger page;

@end

@implementation WallPaperViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _page = 1;
    }
    return self;
}

#pragma mark -- getters and setters
- (RACCommand *)categoryCommand{
    if (_categoryCommand == nil) {
        _categoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

                
                [[OMApiProxy sharedInstance] getUrlName:@"http://service.picasso.adesk.com/v1/vertical/category?adult=false&first=1" paramaters:nil success:^(NSDictionary *responseObject) {
                    NSInteger code = [responseObject[@"code"] integerValue];
                    if (code == 0) {
                       NSArray *category = responseObject[@"res"][@"category"];
                        [subscriber sendNext:category];
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
    return _categoryCommand;
}

- (RACCommand *)listCommand{
    if (_listCommand == nil) {
        _listCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSString *categoryId = input[@"categoryId"];
                BOOL first = [input[@"first"] boolValue];
                if (first) {
                    self.page = 1;
                }
                NSString *url = [NSString stringWithFormat:@"http://service.picasso.adesk.com/v1/vertical/category/%@/vertical?limit=30&adult=false&first=%ld&order=new",categoryId,(long)self.page];
                [[OMApiProxy sharedInstance] getUrlName:url paramaters:nil success:^(NSDictionary *responseObject) {
                    NSInteger code = [responseObject[@"code"] integerValue];
                    if (code == 0) {
                        NSArray *vertical = responseObject[@"res"][@"vertical"];
                        [subscriber sendNext:vertical];
                        //一定要加上sendCompleted这个方法,不然无法再次执行该command
                        [subscriber sendCompleted];
                        if (vertical.count > 0) {
                            self.page ++;
                        }
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
    return _listCommand;
}


- (RACCommand *)commentsCommand{
    if (_commentsCommand == nil) {
        _commentsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSString *categoryId = input;
                NSString *url = [NSString stringWithFormat:@"http://service.picasso.adesk.com/v2/vertical/vertical/%@/comment",categoryId];
                [[OMApiProxy sharedInstance] getUrlName:url paramaters:nil success:^(NSDictionary *responseObject) {
                    NSInteger code = [responseObject[@"code"] integerValue];
                    if (code == 0) {
                        NSArray *vertical = responseObject[@"res"][@"comment"];
                        [subscriber sendNext:vertical];
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
    return _commentsCommand;
}

@end
