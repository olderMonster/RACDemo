//
//  HomeViewController.h
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArticleViewModel.h"

@interface ArticleViewController : UIViewController

@property (nonatomic , assign)ArticleSourceType type;
@property (nonatomic , strong)NSString *date;

@end
