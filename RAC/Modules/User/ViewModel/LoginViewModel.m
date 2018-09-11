//
//  LoginViewModel.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "LoginViewModel.h"

#import "OMApiProxy.h"

@implementation LoginViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark -- getters and setters
- (RACSignal *)paramsSignal{
    if (_paramsSignal == nil) {
            _paramsSignal = [[RACSignal combineLatest:@[self.mobileSignal,self.passwordSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
                RACTupleUnpack(NSString *username , NSString *psd) = value;
                //@()将值变量装箱成对象
                NSNumber *next = @([username length] == 11 && [psd length] >= 6);
                return next;
            }];

        
//        _paramsSignal = [RACSignal combineLatest:@[self.mobileSignal,self.passwordSignal] reduce:^id _Nullable(NSString * mobile,NSString * password){
//            NSNumber *number = @(mobile.length == 11 && (password.length > 5));
//            NSLog(@"number = %@",number);
//            return number;
//        }];
    }
    return _paramsSignal;
}



- (RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                
                NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                if ([input isKindOfClass:[NSDictionary class]]) {
                    [params addEntriesFromDictionary:input];
                }
                
                [[OMApiProxy sharedInstance] getUrlName:@"" paramaters:params success:^(NSDictionary *responseObject) {
                    
                    [subscriber sendNext:responseObject];
                    //一定要加上sendCompleted这个方法,不然无法再次执行该command
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return  nil;
            }];
            
            
        }];
    }
    return _loginCommand;
}


@end
