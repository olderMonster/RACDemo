//
//  Action_WallPaper.h
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Target_WallPaper : NSObject

//壁纸分类
- (UIViewController *)Action_nativeFetchWallPaperCategoryViewController:(NSDictionary *)params;

//壁纸列表
- (UIViewController *)Action_nativeFetchWallPaperViewController:(NSDictionary *)params;

//壁纸评论
- (UIViewController *)Action_nativeFetchWallPaperCommentViewController:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
