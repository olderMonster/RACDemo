//
//  WallPaperCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface WallPaperCell()

@property (nonatomic , strong)UIImageView *wallpaperImageView;

@end

@implementation WallPaperCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.wallpaperImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.wallpaperImageView.frame = self.contentView.bounds;
}

#pragma mark -- getters and setters
- (UIImageView *)wallpaperImageView{
    if (_wallpaperImageView == nil) {
        _wallpaperImageView = [[UIImageView alloc] init];
    }
    return _wallpaperImageView;
}

- (void)setWallpaper:(WallPaper *)wallpaper{
    _wallpaper = wallpaper;
    [self.wallpaperImageView sd_setImageWithURL:[NSURL URLWithString:_wallpaper.thumb]];
}


@end
