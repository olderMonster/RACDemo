//
//  RegisterViewModel.m
//  RAC
//
//  Created by 印聪 on 2018/9/7.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "RegisterViewModel.h"

#import "OMApiProxy.h"

@implementation RegisterViewModel









#pragma mark -- getters and setters
- (RACSignal *)paramsSignal{
    if (_paramsSignal == nil) {
        _paramsSignal = [[RACSignal combineLatest:@[self.mobileSignal,self.passwordSignal,self.ensurePsdSignal,self.verifyCodeSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
            RACTupleUnpack(NSString *mobile , NSString *psd , NSString *ensurePsd,NSString *verifyCode) = value;
            //@()将值变量装箱成对象
            NSNumber *next = @(mobile.length == 11 && [psd length] >= 6 && [ensurePsd isEqualToString:psd] && verifyCode.length > 0);
            return next;
        }];
    }
    return _paramsSignal;
}

//- (RACSignal *)verifyCodeParamsSignal{
//    if (_verifyCodeParamsSignal == nil) {
//        _verifyCodeParamsSignal = [[RACSignal combineLatest:@[self.mobileSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
//            RACTupleUnpack(NSString *mobile) = value;
//            //@()将值变量装箱成对象
//            NSNumber *next = @(mobile.length == 11);
//            return next;
//        }];
//    }
//    return _verifyCodeParamsSignal;
//}


- (RACCommand *)verifyCodeCommand{
    if (_verifyCodeCommand == nil) {
        _verifyCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSLog(@"input ===>>> %@",input);
                
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
    return _verifyCodeCommand;
}


- (RACCommand *)registerCommand{
    if (_registerCommand == nil) {
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSLog(@"input ===>>> %@",input);
                
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
    return _registerCommand;
}

@end
