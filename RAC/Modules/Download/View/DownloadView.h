//
//  DownloadView.h
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadView : UIView

@property (nonatomic , strong)NSObject *downloadService;
@property (nonatomic , assign)CGFloat progress;

@end

NS_ASSUME_NONNULL_END
