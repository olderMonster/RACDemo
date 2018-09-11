//
//  DownloadViewController.m
//  RAC
//
//  Created by 印聪 on 2018/9/10.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "DownloadViewController.h"

#import "OMDownloadManager.h"

#import "DownloadView.h"

@interface DownloadViewController ()<OMDownloadServiceDelegate>

@property (nonatomic , strong)NSArray *downloadViewsArray;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"下载任务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDownloadView];
    
}

- (void)setupDownloadView{
    
    NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
    NSArray *downloadTasks = [OMDownloadManager sharedInstance].downloadProxyMArray;
    for (NSInteger index = 0; index < downloadTasks.count; index ++) {
        OMDownloadService *downloadService = downloadTasks[index];
        downloadService.delegate = self;
        
        DownloadView *downloadView = [[DownloadView alloc] initWithFrame:CGRectMake(20, 64 + 10 + (50 + 10) * index, self.view.bounds.size.width - 40, 50)];
        downloadView.backgroundColor = [UIColor lightGrayColor];
        downloadView.downloadService = downloadService;
        downloadView.progress = downloadService.progress;
        [self.view addSubview:downloadView];
        
        [tmpMArray addObject:downloadView];
    }
    self.downloadViewsArray = tmpMArray.copy;
}

#pragma mark -- OMDownloadServiceDelegate
- (void)service:(OMDownloadService *)downloadService shouldUpdateProgress:(CGFloat)progress{
    
    for (DownloadView *view in self.downloadViewsArray) {
        if ([view.downloadService isEqual:downloadService]) {
            view.progress = progress;
        }
    }
}

#pragma mark -- getters and setters




@end
