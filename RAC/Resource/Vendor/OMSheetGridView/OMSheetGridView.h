//
//  AlertSheetView.h
//  RAC
//
//  Created by 印聪 on 2018/9/17.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMSheetGridItem.h"
@class OMSheetGridView;
NS_ASSUME_NONNULL_BEGIN



@protocol OMSheetGridViewDelegate <NSObject>

- (void)view:(OMSheetGridView *)gridView didSelectedGridItem:(OMSheetGridItem *)item;

@end


@interface OMSheetGridView : UIView

/**
 分享平台,默认为微信、朋友圈、QQ、QQ空间、微博等5个平台
 */
@property (nonatomic , strong)NSArray <NSArray *>*itemsArray;


/**
 透明背景颜色
 */
@property (nonatomic , strong)UIColor *backgroundViewColor;

/**
 动画持续时间
 */
@property (nonatomic , assign)CGFloat duration;

/**
 左边距
 */
@property (nonatomic , assign)CGFloat leftEdgeInset;


/**
 右边距
 */
@property (nonatomic , assign)CGFloat rightEdgeInset;


/**
 每个item的size
 */
@property (nonatomic , assign)CGSize itemSize;


/**
 列数
 */
@property (nonatomic , assign)NSInteger cols;


/**
 取消按钮高度
 */
@property (nonatomic , assign)CGFloat cancelButtonHeight;

@property (nonatomic , weak)id<OMSheetGridViewDelegate>delegate;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
