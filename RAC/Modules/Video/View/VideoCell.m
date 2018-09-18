//
//  VideoCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+RAC.h"

#import "Video.h"
#import "LikeButton.h"

#import "UIColor+RAC.h"

static CGFloat kVideoCellTitleFontSize = 16;
static CGFloat kVideoCellAuthorNameFontSize = 13;
static CGFloat kVideoCellCommentCountFontSize = 10;

CGFloat const kVideoCellAuthorInfoHeight = 50;

@interface VideoCell()

@property (nonatomic , strong)UIImageView *coverImageView;
@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)LikeButton *commentButton;
@property (nonatomic , strong)UIButton *shareButton;

@end

@implementation VideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.commentButton];
        [self.contentView addSubview:self.shareButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.coverImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - kVideoCellAuthorInfoHeight);
    if (self.titleLabel.text) {
        CGRect rect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width - 20, 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
        self.titleLabel.frame = CGRectMake(10, 10, rect.size.width, rect.size.height);
    }
    
    self.avatarImageView.frame = CGRectMake(10, CGRectGetMaxY(self.coverImageView.frame) + 10, kVideoCellAuthorInfoHeight - 20, kVideoCellAuthorInfoHeight - 20);
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height * 0.5;
    if (self.nameLabel.text) {
        CGSize size = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame) + 10, CGRectGetMaxY(self.coverImageView.frame), size.width, kVideoCellAuthorInfoHeight);
    }
    
    CGFloat shareButtonSize = 20;
    self.shareButton.bounds = CGRectMake(0, 0, shareButtonSize, shareButtonSize);
    self.shareButton.center = CGPointMake(self.contentView.bounds.size.width - 10 - shareButtonSize * 0.5, self.avatarImageView.center.y);
    
    CGSize commentSize = [self.commentButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.commentButton.titleLabel.font}];
    self.commentButton.bounds = CGRectMake(0, 0, commentSize.width + kLikeButtonImageSize + 10, 25);
    self.commentButton.center = CGPointMake(self.shareButton.frame.origin.x - 10 - self.commentButton.bounds.size.width * 0.5, self.avatarImageView.center.y);
}


#pragma mark -- event response
- (void)shareAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(willShareVideoAtIndexCell:)]) {
        [self.delegate willShareVideoAtIndexCell:self];
    }
}


#pragma mark -- getters and setters
- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:kVideoCellTitleFontSize];
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIImageView *)avatarImageView{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:kVideoCellAuthorNameFontSize];
    }
    return _nameLabel;
}


- (LikeButton *)commentButton{
    if (_commentButton == nil) {
        _commentButton = [LikeButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"video_comment_btn"] forState:UIControlStateNormal];
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor colorWithHex:@"bfbfbf"] forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:kVideoCellCommentCountFontSize];
    }
    return _commentButton;
}

- (UIButton *)shareButton{
    if (_shareButton == nil) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"video_share_btn"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}


- (void)setMedia:(Media *)media{
    _media = media;
    if (_media.type == MediaTypeVideo) {
        Video *video = (Video *)_media;
        self.titleLabel.text = video.title;
        [self.coverImageView rac_imageWithuUrl:video.cover_feed];
        
        [self.avatarImageView rac_imageWithuUrl:video.author.icon];
        self.nameLabel.text = video.author.name;
        
//        if (video.replyCount == 0) {
//            [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
//        }else{
//            [_commentButton setTitle:[NSString stringWithFormat:@"%ld",video.replyCount] forState:UIControlStateNormal];
//        }
    }
}

@end
