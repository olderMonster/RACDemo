//
//  ParagraphCell.h
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat const kParagraphCellLabelFontSize;

@interface ParagraphCell : UITableViewCell

@property (nonatomic , strong)NSString *paragraph;

@end

NS_ASSUME_NONNULL_END
