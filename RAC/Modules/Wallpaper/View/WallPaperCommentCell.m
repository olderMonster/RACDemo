//
//  WallPaperCommentCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCommentCell.h"

#import "LikeButton.h"

#import "UIColor+RAC.h"
#import "UIImageView+RAC.h"

CGFloat const kCommentUserNameFontSize = 12;
CGFloat const kCommentCreateAtFontSize = 10;
CGFloat const kCommentContentFontSize = 14;

@interface WallPaperCommentCell()

@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *createAtLabel;
@property (nonatomic , strong)LikeButton *likeButton;
@property (nonatomic , strong)UILabel *contentLabel;

@end

@implementation WallPaperCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.likeButton];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.createAtLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.avatarImageView.frame = self.comment.cellFrame.avatarImageViewRect;
    self.likeButton.frame = self.comment.cellFrame.likeButtonRect;
    self.nameLabel.frame = self.comment.cellFrame.nameLabelRect;
    self.contentLabel.frame = self.comment.cellFrame.contentLabelRect;
    self.createAtLabel.frame = self.comment.cellFrame.createAtRect;
    
    self.avatarImageView.layer.cornerRadius = 3.0;
}


#pragma mark -- event response
- (void)likeCommentAction:(UIButton *)likeButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:willUpdateCommentLikeStatus:)]) {
        //如果当前为未点赞，此时传过去应该是做点赞操作，否则为取消点赞操作
        [self.delegate cell:self willUpdateCommentLikeStatus:!likeButton.selected];
    }
}


#pragma mark -- getters and setters
- (UIImageView *)avatarImageView{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:kCommentUserNameFontSize];
    }
    return _nameLabel;
}

- (UILabel *)createAtLabel{
    if (_createAtLabel == nil) {
        _createAtLabel = [[UILabel alloc] init];
        _createAtLabel.font = [UIFont systemFontOfSize:kCommentCreateAtFontSize];
        _createAtLabel.textColor = [UIColor lightGrayColor];
    }
    return _createAtLabel;
}

- (LikeButton *)likeButton{
    if (_likeButton == nil) {
        _likeButton = [LikeButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"like_normal_btn"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"like_selected_btn"] forState:UIControlStateSelected];
        
        [_likeButton setTitleColor:[UIColor colorWithHex:@"bfbfbf"] forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor colorWithHex:@"1296db"] forState:UIControlStateSelected];
        
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:kLikeButtonCountFontSize];
        
        [_likeButton addTarget:self action:@selector(likeCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:kCommentContentFontSize];
        _contentLabel.textColor = [UIColor lightGrayColor];
    }
    return _contentLabel;
}



- (void)setComment:(WallPaperComment *)comment{
    _comment = comment;
    
    self.likeButton.selected = _comment.liked;
    [self.avatarImageView rac_circleImageWithUrl:_comment.user.avatar];
    self.nameLabel.text = _comment.user.name;
    self.createAtLabel.text =  _comment.createAt;
    self.contentLabel.text = _comment.content;
    [self.likeButton setTitle:_comment.sizeStr forState:UIControlStateNormal];
}

@end
