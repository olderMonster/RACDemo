//
//  WallPaperCommentCell.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPaperComment.h"
@class WallPaperCommentCell;
NS_ASSUME_NONNULL_BEGIN

extern CGFloat const kCommentUserNameFontSize;
extern CGFloat const kCommentCreateAtFontSize;
extern CGFloat const kCommentContentFontSize;


@protocol WallPaperCommentCellDelegate <NSObject>


/**
 即将点赞评论

 @param cell 当前cell
 @param like 点赞状态(YES为点赞，NO为取消点赞)
 */
- (void)cell:(WallPaperCommentCell *)cell willUpdateCommentLikeStatus:(BOOL)like;

@end

@interface WallPaperCommentCell : UITableViewCell

@property (nonatomic , strong)WallPaperComment *comment;

@property (nonatomic , weak)id<WallPaperCommentCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
