//
//  AlertSheetCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/17.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMSheetGridCell.h"

#import "UIColor+RAC.h"

@interface OMSheetGridCell()

@property (nonatomic , strong)UIImageView *iconImageView;
@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation OMSheetGridCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat iconSize = 40;
    self.iconImageView.frame = CGRectMake(self.contentView.bounds.size.width * 0.5 - 40 * 0.5, 10, iconSize, iconSize);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), self.contentView.bounds.size.width, self.contentView.bounds.size.height - CGRectGetMaxY(self.iconImageView.frame));
}


#pragma mark -- getters and setters
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHex:@"bfbfbf"];
    }
    return _titleLabel;
}


- (void)setItem:(OMSheetGridItem *)item{
    _item = item;
    self.titleLabel.text = _item.title;
    self.iconImageView.image = _item.iconImage;
}


@end
