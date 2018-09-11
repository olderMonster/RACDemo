//
//  WallpaperViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCategoryViewController.h"

#import "WallPaperCategory.h"
#import "WallPaperViewModel.h"

#import "CTMediator+Download.h"
#import "CTMediator+WallPaper.h"

#import "WallPaperCategoryCell.h"

#import "WallPaperViewController.h"
#import "DownloadViewController.h"

#import <MJRefresh/MJRefresh.h>

@interface WallPaperCategoryViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *wallpaperTableView;

@property (nonatomic , strong)NSArray *wallpapersArray;

@property (nonatomic , strong)WallPaperViewModel *wallpaperViewModel;

@end

@implementation WallPaperCategoryViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
    self.navigationItem.title = @"壁纸类别";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wallpaperTableView];
    
    [self setupRefresh];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.wallpaperTableView.frame = self.view.bounds;
}


#pragma mark -- private method
- (void)setupRefresh{
    self.wallpaperTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.wallpaperTableView.mj_header beginRefreshing];
}


- (void)setupNavigationItems{
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadButton setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    downloadButton.frame = CGRectMake(0, 0, 20, 20);
    UIView *rightView = [[UIView alloc] initWithFrame:downloadButton.bounds];
    [rightView addSubview:downloadButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [[downloadButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIViewController *downloadVC = [[CTMediator sharedInstance] CTMediator_viewControllerForDownloadViewController];
        [self.navigationController pushViewController:downloadVC animated:YES];
    }];
}

- (void)loadData{
    //写法2(常用写法)：
    [self.wallpaperViewModel.categoryCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        if ([x isKindOfClass:[NSArray class]]) {
            NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in x) {
                WallPaperCategory *paper = [[WallPaperCategory alloc] initWithWallpaper:dict];
                [tmpMArray addObject:paper];
            }
            self.wallpapersArray = tmpMArray.copy;
            [self.wallpaperTableView reloadData];
        }
        [self.wallpaperTableView.mj_header endRefreshing];
        
    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.wallpaperViewModel.categoryCommand.errors subscribeNext:^(NSError *error) {
        [self.wallpaperTableView.mj_header endRefreshing];
    }];
    [self.wallpaperViewModel.categoryCommand execute:nil];
}





#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wallpapersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    WallPaperCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WallPaperCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.category = self.wallpapersArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WallPaperCategory *category = self.wallpapersArray[indexPath.row];
    UIViewController *wallpaperVC = [[CTMediator sharedInstance] CTMediator_viewControllerForWallPaperViewController:@{@"categoryId":category.cid}];
    [self.navigationController pushViewController:wallpaperVC animated:YES];
}


#pragma mark -- getters and setters
- (UITableView *)wallpaperTableView{
    if (_wallpaperTableView == nil) {
        _wallpaperTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _wallpaperTableView.backgroundColor = [UIColor whiteColor];
        _wallpaperTableView.dataSource = self;
        _wallpaperTableView.delegate = self;
        _wallpaperTableView.tableFooterView = [[UIView alloc] init];
        _wallpaperTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        CGFloat coverW = self.view.bounds.size.width - 20;
        CGFloat coverH = coverW * 3.0/4.0 + 10;
        _wallpaperTableView.rowHeight = coverH;
    }
    return _wallpaperTableView;
}

- (WallPaperViewModel *)wallpaperViewModel{
    if (_wallpaperViewModel == nil) {
        _wallpaperViewModel = [[WallPaperViewModel alloc] init];
    }
    return _wallpaperViewModel;
}

@end
