//
//  OMVideoViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/19.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMVideoViewController.h"

@interface OMVideoViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *videoTableView;

@property (nonatomic , strong)NSArray *videosArray;

@end

@implementation OMVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"视频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.videoTableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}


#pragma mark -- getters and setters
- (UITableView *)videoTableView{
    if (_videoTableView == nil) {
        _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _videoTableView.backgroundColor = [UIColor whiteColor];
        _videoTableView.dataSource = self;
        _videoTableView.delegate = self;
        _videoTableView.tableFooterView = [[UIView alloc] init];
    }
    return _videoTableView;
}


@end
