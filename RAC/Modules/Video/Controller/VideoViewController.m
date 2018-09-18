//
//  VideoViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "VideoViewController.h"

#import "Video.h"
#import "Media.h"
#import "VideoViewModel.h"

#import "VideoCell.h"
#import "OMSheetGridView.h"

@interface VideoViewController ()<UITableViewDataSource , UITableViewDelegate , VideoCellDelegate , OMSheetGridViewDelegate>

@property (nonatomic , strong)UITableView *videoTableView;

@property (nonatomic , strong)VideoViewModel *videoVideModel;
@property (nonatomic , strong)NSArray *videosArray;

@end

@implementation VideoViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.videoTableView];
    
    [self bindViewModel];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.videoTableView.frame = self.view.bounds;
}


#pragma mark -- private method
- (void)bindViewModel{
    [self.videoVideModel.videosCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
     
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        if ([x isKindOfClass:[NSArray class]]) {
            NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in x) {
                Media *media = [Media mediaWithDict:dict];
                //视频
                if (media.type == MediaTypeVideo) {
                    [tmpMArray addObject:media];
                }
                self.videosArray = tmpMArray.copy;
                [self.videoTableView reloadData];
                
            }
            
        }
        
    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.videoVideModel.videosCommand.errors subscribeNext:^(NSError *error) {
    }];
    //如果有日期就是日期当天的文章，否则就是今天的文章
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [self.videoVideModel.videosCommand execute:dict];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    cell.media = self.videosArray[indexPath.row];
    return cell;
}


#pragma mark -- VideoCellDelegate
- (void)willShareVideoAtIndexCell:(VideoCell *)cell{
    OMSheetGridView *shareView = [[OMSheetGridView alloc] init];
    OMSheetGridItem *wexin = [[OMSheetGridItem alloc] initWithTitle:@"微信" iconImage:[UIImage imageNamed:@"weixin"]];
    OMSheetGridItem *wechat = [[OMSheetGridItem alloc] initWithTitle:@"w朋友圈" iconImage:[UIImage imageNamed:@"wechat"]];
    OMSheetGridItem *qq = [[OMSheetGridItem alloc] initWithTitle:@"QQ" iconImage:[UIImage imageNamed:@"qq"]];
    OMSheetGridItem *qqzone = [[OMSheetGridItem alloc] initWithTitle:@"QQ空间" iconImage:[UIImage imageNamed:@"qqzone"]];
    OMSheetGridItem *sina = [[OMSheetGridItem alloc] initWithTitle:@"微博" iconImage:[UIImage imageNamed:@"sina"]];
    
    OMSheetGridItem *collection = [[OMSheetGridItem alloc] initWithTitle:@"收藏" iconImage:[UIImage imageNamed:@"video_collection_icon"]];
    OMSheetGridItem *notInterested = [[OMSheetGridItem alloc] initWithTitle:@"不感兴趣" iconImage:[UIImage imageNamed:@"video_not_interest_icon"]];
    OMSheetGridItem *like = [[OMSheetGridItem alloc] initWithTitle:@"顶" iconImage:[UIImage imageNamed:@"video_like_icon"]];
    OMSheetGridItem *unlike = [[OMSheetGridItem alloc] initWithTitle:@"踩" iconImage:[UIImage imageNamed:@"video_unlike_icon"]];
    OMSheetGridItem *report = [[OMSheetGridItem alloc] initWithTitle:@"举报" iconImage:[UIImage imageNamed:@"video_report_icon"]];
    shareView.itemsArray = @[@[wexin,wechat,qq,qqzone,sina],@[collection,notInterested,like,unlike,report]];
    shareView.delegate = self;
    [shareView show];
}


#pragma mark -- OMSheetGridViewDelegate
- (void)view:(OMSheetGridView *)gridView didSelectedGridItem:(OMSheetGridItem *)item{
    
}

#pragma mark -- getters and setters
- (UITableView *)videoTableView{
    if (_videoTableView == nil) {
        _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _videoTableView.backgroundColor = [UIColor whiteColor];
        _videoTableView.dataSource = self;
        _videoTableView.delegate = self;
        _videoTableView.tableFooterView = [[UIView alloc] init];
        CGFloat cellHeight = self.view.bounds.size.width * 720.0/1242.0 + kVideoCellAuthorInfoHeight;
        _videoTableView.rowHeight = cellHeight;
    }
    return _videoTableView;
}

- (VideoViewModel *)videoVideModel{
    if (_videoVideModel == nil) {
        _videoVideModel = [[VideoViewModel alloc] init];
    }
    return _videoVideModel;
}


@end
