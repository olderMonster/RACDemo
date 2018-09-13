//
//  WallPaperComment.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperComment.h"

#import "DateFormatterManager.h"


@interface WallPaperComment()

@property (nonatomic , strong , readwrite)WallPaperCommentCellFrame *cellFrame;
@property (nonatomic , copy , readwrite)NSString *createAt;
@property (nonatomic , assign , readwrite)NSString *sizeStr; //点赞文本，如果size>0,sizeStr的整形值==size，否则size=@“赞”

@end

@implementation WallPaperComment

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        self.liked = NO;
        self.cid = dict[@"id"];
        self.content = dict[@"content"];
        
        //当点赞数为0的时候显示“赞”，否则显示已点赞数
        self.size = [dict[@"size"] integerValue];
        if ([dict.allKeys containsObject:@"atime"]) {
            self.atime = [dict[@"atime"] doubleValue];
            self.createAt = [[DateFormatterManager sharedInstance] createAt:self.atime];
        }
        self.isup = [dict[@"isup"] boolValue];
        
        NSDictionary *reply_meta = dict[@"reply_meta"];
        self.parent_id = reply_meta[@"parent_id"];
        self.comment_id = reply_meta[@"comment_id"];
        self.uid = reply_meta[@"uid"];
        
        NSDictionary *user = dict[@"user"];
        self.user = [[User alloc] initWithDict:user];
        
        NSDictionary *reply_user = dict[@"reply_user"];
        if (reply_user && reply_user.allKeys.count > 0) {
            self.replyUser = [[User alloc] initWithDict:reply_user];
        }
        
        self.cellFrame = [[WallPaperCommentCellFrame alloc] initWithComment:self];
        
    }
    return self;
}

- (NSString *)sizeStr{
    _sizeStr = self.size == 0?@"赞":[NSString stringWithFormat:@"%ld",self.size];
    return _sizeStr;
}

@end
