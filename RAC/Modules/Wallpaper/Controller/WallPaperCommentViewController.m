//
//  WallPaperCommentViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/11.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperCommentViewController.h"

#import "WallPaperComment.h"
#import "WallPaperViewModel.h"

#import "WallPaperCommentCell.h"

@interface WallPaperCommentViewController ()<UITableViewDataSource , UITableViewDelegate , WallPaperCommentCellDelegate>

@property (nonatomic , strong)UITableView *commentTableView;
@property (nonatomic , strong)NSArray *commentsArray;

@property (nonatomic , strong)WallPaperViewModel *wallpaperViewModel;

@end

@implementation WallPaperCommentViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.commentTableView];
    
    [self bindViewModel];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.commentTableView.frame = self.view.bounds;
}


#pragma mark -- private method
- (void)bindViewModel{
    [self.wallpaperViewModel.commentsCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        if ([x isKindOfClass:[NSArray class]]) {
            NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in x) {
                WallPaperComment *comment = [[WallPaperComment alloc] initWithDict:dict];
                [tmpMArray addObject:comment];
            }
            self.commentsArray = tmpMArray.copy;
        
            [self.commentTableView reloadData];
        }

    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.wallpaperViewModel.commentsCommand.errors subscribeNext:^(NSError *error) {
      
    }];

    [self.wallpaperViewModel.commentsCommand execute:self.wallpaperId];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    WallPaperCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WallPaperCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    cell.comment = self.commentsArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WallPaperComment *comment = self.commentsArray[indexPath.row];
    return comment.cellFrame.height;
}


#pragma mark -- WallPaperCommentCellDelegate
- (void)cell:(WallPaperCommentCell *)cell willUpdateCommentLikeStatus:(BOOL)like{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [self.commentTableView indexPathForCell:cell];
        WallPaperComment *comment = self.commentsArray[indexPath.row];
        comment.size = like?comment.size + 1:comment.size - 1;
        comment.liked = like;
        NSMutableArray *tmpMArray = [[NSMutableArray alloc] initWithArray:self.commentsArray];
        tmpMArray[indexPath.row] = comment;
        self.commentsArray = tmpMArray.copy;
        [self.commentTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}


#pragma mark -- getters and setters
- (UITableView *)commentTableView{
    if (_commentTableView == nil) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _commentTableView.backgroundColor = [UIColor whiteColor];
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        _commentTableView.tableFooterView = [[UIView alloc] init];
    }
    return _commentTableView;
}


- (WallPaperViewModel *)wallpaperViewModel{
    if (_wallpaperViewModel == nil) {
        _wallpaperViewModel = [[WallPaperViewModel alloc] init];
    }
    return _wallpaperViewModel;
}

@end
