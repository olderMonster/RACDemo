//
//  CTMediator+WallPaper.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (WallPaper)

- (UIViewController *)CTMediator_viewControllerForWallPaperCategoryViewController;
- (UIViewController *)CTMediator_viewControllerForWallPaperViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
