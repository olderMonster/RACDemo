//
//  MediaPlayerView.m
//  RAC
//
//  Created by 印聪 on 2018/9/19.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "MediaPlayerView.h"

#import <AVKit/AVKit.h>

static MediaPlayerView *sharedInstance = nil;

@interface MediaPlayerView ()

@property (nonatomic , strong)AVPlayer *player;
@property (nonatomic , strong)AVPlayerItem *mediaItem;

@end

@implementation MediaPlayerView

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MediaPlayerView alloc] init];
    });
    return sharedInstance;
}

- (void)play:(NSString *)url{
    self.mediaItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.mediaItem];
    [self.player play];
}

@end
