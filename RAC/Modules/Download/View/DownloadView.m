//
//  DownloadView.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "DownloadView.h"

@interface DownloadView()

@property (nonatomic , strong)UILabel *progressLabel;
@property (nonatomic , strong)UIProgressView *progressView;

@end


@implementation DownloadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.progressLabel];
        [self addSubview:self.progressView];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.progressLabel];
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.progressLabel.frame = CGRectMake(0, 0, self.bounds.size.width - 5, 30);
    self.progressView.frame = CGRectMake(0, CGRectGetMaxY(self.progressLabel.frame) + 10, self.bounds.size.width, self.bounds.size.height - self.progressLabel.bounds.size.height);
}

#pragma mark -- getters and setters
- (UILabel *)progressLabel{
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:12];
        _progressLabel.textAlignment = NSTextAlignmentRight;
    }
    return _progressLabel;
}

- (UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
    }
    return _progressView;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = _progress;
        self.progressLabel.text = [NSString stringWithFormat:@"下载进度：%.0f%%",_progress * 100];
    });
}

@end
