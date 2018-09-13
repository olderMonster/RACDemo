//
//  User.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic , copy)NSString *uid;   //用户id
@property (nonatomic , copy)NSString *name;  //用户昵称
@property (nonatomic , copy)NSString *avatar;    //用户头像
@property (nonatomic , assign)NSInteger gender;
@property (nonatomic , assign)NSInteger follower;
@property (nonatomic , assign)NSInteger following;
@property (nonatomic , assign)BOOL isvip;
@property (nonatomic , assign)double viptime;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
