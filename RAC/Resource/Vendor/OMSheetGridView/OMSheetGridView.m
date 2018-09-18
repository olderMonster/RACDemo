//
//  Alertself.m
//  RAC
//
//  Created by 印聪 on 2018/9/17.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMSheetGridView.h"

#import "UIColor+RAC.h"

#import "OMSheetGridCell.h"


#define kSheetGridCellSize CGSizeMake([UIScreen mainScreen].bounds.size.width/5.0, 80)

@interface OMSheetGridView()<UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic , strong)UIView *backgroundView;

@property (nonatomic , strong)UIView *contentView;
@property (nonatomic , strong)UIButton *cancelButton;


/**
 透明背景颜色
 */
@property (nonatomic , strong)UIColor *backgroundViewColor;

/**
 动画持续时间
 */
@property (nonatomic , assign)CGFloat duration;




@property (nonatomic , strong)NSArray <UICollectionView *>*collectionViewsArray;

@end

@implementation OMSheetGridView


- (instancetype)init{
    self = [super init];
    if (self) {
        _duration = 0.3;
        
        _backgroundViewColor = [UIColor blackColor];
//        _backgroundViewColor = [UIColor colorWithHex:@"bfbfbf"];
        [self addSubview:self.contentView];
        [self addSubview:self.cancelButton];

    }
    return self;
}



#pragma mark -- public method
- (void)show{
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self];
    
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
    CGFloat contentViewH = self.itemsArray.count * kSheetGridCellSize.height;
    self.contentView.frame = CGRectMake(20, 0,[UIScreen mainScreen].bounds.size.width - 40 , contentViewH);
    self.cancelButton.frame = CGRectMake(self.contentView.frame.origin.x, CGRectGetMaxY(self.contentView.frame) + 10, self.contentView.bounds.size.width, 40);
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.cancelButton.frame) + 10);
    
    for (NSInteger index = 0; index < self.collectionViewsArray.count; index++) {
        UICollectionView *collectionView = self.collectionViewsArray[index];
        collectionView.frame = CGRectMake(0, kSheetGridCellSize.height * index, self.contentView.bounds.size.width, kSheetGridCellSize.height);
        [collectionView reloadData];
    }
    
    
    self.backgroundView.backgroundColor = [self.backgroundViewColor colorWithAlphaComponent:0.0];
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    [UIView animateWithDuration:self.duration animations:^{
        self.backgroundView.backgroundColor = [self.backgroundViewColor colorWithAlphaComponent:0.4];
        self.frame = frame;
    }];
    
}

- (void)dismiss{
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:self.duration animations:^{
        self.backgroundView.backgroundColor = [self.backgroundViewColor colorWithAlphaComponent:0.0];
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
    }];
}



#pragma mark -- event response



#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.itemsArray[collectionView.tag];
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OMSheetGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.item = self.itemsArray[collectionView.tag][indexPath.row];
    return cell;
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(view:didSelectedGridItem:)]) {
        [self.delegate view:self didSelectedGridItem:self.itemsArray[collectionView.tag][indexPath.row]];
    }
    [self dismiss];
}


#pragma mark -- getters and setters
- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [self.backgroundViewColor colorWithAlphaComponent:0.0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}


- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 3.0f;
    }
    return _contentView;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 3.0f;
    }
    return _cancelButton;
}

- (void)setItemsArray:(NSArray<NSArray *> *)itemsArray{
    _itemsArray = itemsArray;
    NSMutableArray *tmpMArray = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < _itemsArray.count; index++) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = kSheetGridCellSize;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.tag = index;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[OMSheetGridCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [self.contentView addSubview:collectionView];
        [tmpMArray addObject:collectionView];
       
    }
    self.collectionViewsArray = tmpMArray.copy;
}


@end
