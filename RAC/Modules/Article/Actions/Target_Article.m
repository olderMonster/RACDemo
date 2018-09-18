//
//  Target_Article.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "Target_Article.h"
#import "ArticleViewController.h"
@implementation Target_Article

- (UIViewController *)Action_nativeFetchArticleViewController:(NSDictionary *)params{
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    articleVC.type = [params[@"type"] integerValue];
    articleVC.date = params[@"date"];
    return articleVC;
}

@end
