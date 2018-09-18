//
//  VideoCell.h
//  RAC
//
//  Created by 印聪 on 2018/9/14.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
@class VideoCell;
NS_ASSUME_NONNULL_BEGIN


extern CGFloat const kVideoCellAuthorInfoHeight;

@protocol VideoCellDelegate <NSObject>

- (void)willShareVideoAtIndexCell:(VideoCell *)cell;

@end


@interface VideoCell : UITableViewCell

@property (nonatomic , strong)Media *media;

@property (nonatomic , weak)id<VideoCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
