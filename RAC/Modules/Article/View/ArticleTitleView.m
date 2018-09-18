//
//  ArticleTitleView.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "ArticleTitleView.h"

@interface ArticleTitleView()

@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *authorLabel;

@end

@implementation ArticleTitleView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.authorLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 20, self.bounds.size.width - 40, 20);
    self.authorLabel.frame = CGRectMake(self.bounds.size.width * 0.5, CGRectGetMaxY(self.titleLabel.frame) + 10, self.bounds.size.width * 0.5, 20);
}

#pragma mark -- getters and setters
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)authorLabel{
    if (_authorLabel == nil) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:13];
        _authorLabel.textColor = [UIColor lightGrayColor];
    }
    return _authorLabel;
}


- (void)setArtilceTitle:(NSString *)artilceTitle{
    _artilceTitle = artilceTitle;
    self.titleLabel.text = _artilceTitle;
}

- (void)setArticleAuthor:(NSString *)articleAuthor{
    _articleAuthor = articleAuthor;
    self.authorLabel.text = [NSString stringWithFormat:@"——%@",_articleAuthor];
}


@end
