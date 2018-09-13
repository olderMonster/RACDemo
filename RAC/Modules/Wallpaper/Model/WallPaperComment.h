//
//  WallPaperComment.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "WallPaperCommentCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallPaperComment : NSObject

@property (nonatomic , copy)NSString *cid; //评论id
@property (nonatomic , copy)NSString *content; //评论内容
@property (nonatomic , assign)NSInteger size;  //点赞数
 //点赞文本，如果size>0,sizeStr的整形值==size，否则size=@“赞”。该字段为额外增加的字段
@property (nonatomic , assign , readonly)NSString *sizeStr;
@property (nonatomic , assign)double atime;
@property (nonatomic , assign)BOOL isup;  //封面
@property (nonatomic , copy , readonly)NSString *createAt; //根据atime值计算



//用户是否对当前评论点赞，默认为NO
@property (nonatomic , assign)BOOL liked;

//所回复的评论的元数据
@property (nonatomic , copy)NSString *parent_id;
@property (nonatomic , copy)NSString *comment_id;
@property (nonatomic , copy)NSString *uid;

@property (nonatomic , strong)User *user;//发布评论的用户信息
@property (nonatomic , strong)User *replyUser; //所回复的评论的发表用户信息

@property (nonatomic , strong , readonly)WallPaperCommentCellFrame *cellFrame;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
