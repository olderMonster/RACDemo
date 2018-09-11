//
//  WallpaperCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCategoryCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface WallPaperCategoryCell()

@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *countLabel;
@property (nonatomic , strong)UIImageView *coverImageView;

@end

@implementation WallPaperCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.countLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //640x480
    CGFloat width = self.contentView.bounds.size.width - 20;
    self.coverImageView.frame = CGRectMake(self.contentView.bounds.size.width * 0.5 - width * 0.5, 10, width, self.bounds.size.height - 10);
    
    CGSize nameSize = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
    self.nameLabel.frame = CGRectMake(self.coverImageView.frame.origin.x + 10, self.coverImageView.frame.origin.y + 10, nameSize.width, nameSize.height);
    
    CGSize countSize = [self.countLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, CGRectGetMaxY(self.nameLabel.frame) - countSize.height + 2, countSize.width, countSize.height);
}

#pragma mark -- getters and setters
- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.cornerRadius = 3.0f;
    }
    return _coverImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:20];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = [UIFont systemFontOfSize:14];
    }
    return _countLabel;
}

- (void)setCategory:(WallPaperCategory *)category{
    _category = category;
    
    self.nameLabel.text = _category.name;
    self.countLabel.text = [NSString stringWithFormat:@"(%ld)",(long)_category.count];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_category.cover]];
}



@end
