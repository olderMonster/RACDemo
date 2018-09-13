//
//  WallpaperViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "WallPaperViewController.h"

#import "WallPaper.h"
#import "OMDownloadManager.h"
#import "WallPaperViewModel.h"
#import "CTMediator+WallPaper.h"

#import "WallPaperCell.h"



#import <Photos/Photos.h>

#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>

@interface WallPaperViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , IDMPhotoBrowserDelegate>

@property (nonatomic , strong)UICollectionView *wallpaperCollectionView;
@property (nonatomic , strong)NSArray *wallpapersArray;

@property (nonatomic , strong)WallPaperViewModel *wallpaperViewModel;

@end

@implementation WallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"壁纸";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wallpaperCollectionView];
    [self setupRefresh];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.wallpaperCollectionView.frame = self.view.bounds;
}

#pragma mark -- private method
- (void)setupRefresh{
    self.wallpaperCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadMoreData:NO];
    }];
    self.wallpaperCollectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self loadMoreData:YES];
    }];
    [self.wallpaperCollectionView.mj_header beginRefreshing];
}

- (void)loadMoreData:(BOOL)more{
    //写法2(常用写法)：
    [self.wallpaperViewModel.listCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        if ([x isKindOfClass:[NSArray class]]) {
            NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in x) {
                WallPaper *paper = [[WallPaper alloc] initWithWallPaper:dict];
                [tmpMArray addObject:paper];
            }
            if (!more) {
                self.wallpapersArray = tmpMArray.copy;
            }else{
                NSMutableArray *tmpdataMArray = [[NSMutableArray alloc] initWithArray:self.wallpapersArray];
                [tmpdataMArray addObjectsFromArray:tmpMArray];
                self.wallpapersArray = tmpdataMArray.copy;
            }
           
            [self.wallpaperCollectionView reloadData];
        }

        if ([self.wallpaperCollectionView.mj_header isRefreshing]) {
            [self.wallpaperCollectionView.mj_header endRefreshing];
        }
        if ([self.wallpaperCollectionView.mj_footer isRefreshing]) {
            [self.wallpaperCollectionView.mj_footer endRefreshing];
        }
    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.wallpaperViewModel.listCommand.errors subscribeNext:^(NSError *error) {
        if ([self.wallpaperCollectionView.mj_header isRefreshing]) {
            [self.wallpaperCollectionView.mj_header endRefreshing];
        }
        if ([self.wallpaperCollectionView.mj_footer isRefreshing]) {
            [self.wallpaperCollectionView.mj_footer endRefreshing];
        }
    }];
    NSMutableDictionary *params = @{@"categoryId":self.categoryId}.mutableCopy;
    if (!more) {
        params[@"first"] = @(YES);
    }
    [self.wallpaperViewModel.listCommand execute:params];
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.wallpapersArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WallPaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.wallpaper = self.wallpapersArray[indexPath.row];
    return cell;
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
    for (WallPaper *wallpaper in self.wallpapersArray) {
        if (wallpaper.img) {
            [tmpMArray addObject:[IDMPhoto photoWithURL:[NSURL URLWithString:wallpaper.img]]];
        }
    }
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:tmpMArray];
    [browser setInitialPageIndex:indexPath.row];
    browser.actionButtonTitles = @[@"下载",@"评论"];
    browser.delegate = self;
    [self presentViewController:browser animated:YES completion:nil];

}

#pragma mark -- IDMPhotoBrowserDelegate
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex{
    if (buttonIndex == 0){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
            // 无权限
            [SVProgressHUD showWithStatus:@"请前往“设置-隐私-照片”中授权应用读取和写入照片"];
        }else{
            WallPaper *wallpaper = self.wallpapersArray[photoIndex];
            [[OMDownloadManager sharedInstance] download:[NSString stringWithFormat:@"http://img5.adesk.com/%@",wallpaper.wid]];
        }
    }
    if (buttonIndex == 1) {
        [photoBrowser dismissViewControllerAnimated:YES completion:^{
            WallPaper *wallpaper = self.wallpapersArray[photoIndex];
            UIViewController *commentVC = [[CTMediator sharedInstance] CTMediator_viewControllerForWallPaperCommentViewController:@{@"wallpaperId":wallpaper.wid}];
            [self.navigationController pushViewController:commentVC animated:YES];
        }];
    }
}

- (IDMCaptionView *)photoBrowser:(IDMPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index{
    WallPaper *wallpaper = self.wallpapersArray[index];
    IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:wallpaper.img]];
    IDMCaptionView *view = [[IDMCaptionView alloc] initWithPhoto:photo];
    return view;
}

#pragma mark -- getters and setters
- (UICollectionView *)wallpaperCollectionView{
    if (_wallpaperCollectionView == nil) {
        //350x540
        CGFloat width = (self.view.bounds.size.width - 10 * 5)/4;
        CGFloat height = width * 540/350.0;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        _wallpaperCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _wallpaperCollectionView.backgroundColor = [UIColor whiteColor];
        _wallpaperCollectionView.contentInset = UIEdgeInsetsMake(5, 10, 10, 10);
        _wallpaperCollectionView.dataSource = self;
        _wallpaperCollectionView.delegate = self;
        [_wallpaperCollectionView registerClass:[WallPaperCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    }
    return _wallpaperCollectionView;
}

- (WallPaperViewModel *)wallpaperViewModel{
    if (_wallpaperViewModel == nil) {
        _wallpaperViewModel = [[WallPaperViewModel alloc] init];
    }
    return _wallpaperViewModel;
}


@end
