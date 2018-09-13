//
//  WallPaperCommentCellFrame.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WallPaperComment;
NS_ASSUME_NONNULL_BEGIN

@interface WallPaperCommentCellFrame : NSObject

@property (nonatomic , assign)CGRect avatarImageViewRect;
@property (nonatomic , assign)CGRect nameLabelRect;
@property (nonatomic , assign)CGRect contentLabelRect;
@property (nonatomic , assign)CGRect createAtRect;
@property (nonatomic , assign)CGRect likeButtonRect;


//整个cell的高度，因这里是动态cell。因此在每次数据转模型时计算cell高度b，也通过这种方式缓存高度
@property (nonatomic , assign , readonly)CGFloat height;

- (instancetype)initWithComment:(WallPaperComment *)comment;

@end

NS_ASSUME_NONNULL_END
