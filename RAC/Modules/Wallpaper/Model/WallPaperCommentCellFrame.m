//
//  WallPaperCommentCellFrame.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCommentCellFrame.h"

#import "WallPaperComment.h"

#import "LikeButton.h"
#import "WallPaperCommentCell.h"

@interface WallPaperCommentCellFrame ()

@property (nonatomic , assign , readwrite)CGFloat height;

@end

@implementation WallPaperCommentCellFrame

- (instancetype)initWithComment:(WallPaperComment *)comment{
    self = [super init];
    if (self) {
        
        UIEdgeInsets contentEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat maxContentX = [UIScreen mainScreen].bounds.size.width - contentEdgeInset.right;
        
        self.avatarImageViewRect = CGRectMake(contentEdgeInset.left, contentEdgeInset.top, 40, 40);
        
        CGSize sizeTextSize = [comment.sizeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentLikeCountFontSize]}];
        //点赞按钮中文本与图片间距为10
        CGFloat likeButtonW = sizeTextSize.width + 10 + kLikeButtonImageSize;
        self.likeButtonRect = CGRectMake(maxContentX - likeButtonW, self.avatarImageViewRect.origin.y + 5, likeButtonW, 20);
        
        CGSize nameSize = [comment.user.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentUserNameFontSize]}];
        self.nameLabelRect = CGRectMake(CGRectGetMaxX(self.avatarImageViewRect) + 5, self.likeButtonRect.origin.y + self.likeButtonRect.size.height * 0.5 - nameSize.height * 0.5, nameSize.width, nameSize.height);
        
        CGSize maxSize = CGSizeMake(maxContentX  - self.nameLabelRect.origin.x, MAXFLOAT);
        CGRect contentBounds = [comment.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFontSize]} context:nil];
        self.contentLabelRect = CGRectMake(self.nameLabelRect.origin.x, CGRectGetMaxY(self.avatarImageViewRect), contentBounds.size.width, contentBounds.size.height);
        
        CGSize createAtSize = [comment.createAt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentCreateAtFontSize]}];
        self.createAtRect = CGRectMake(self.nameLabelRect.origin.x, CGRectGetMaxY(self.contentLabelRect) + 10, createAtSize.width, createAtSize.height);
        
        self.height = CGRectGetMaxY(self.createAtRect) + contentEdgeInset.bottom;
    }
    return self;
}

@end
