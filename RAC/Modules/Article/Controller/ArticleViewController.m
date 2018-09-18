//
//  HomeViewController.m
//  RAC
//
//  Created by 印聪 on 2018/8/31.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "ArticleViewController.h"

#import "ParagraphCell.h"

#import "ArticleTitleView.h"

@interface ArticleViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)ArticleTitleView *titleView;
@property (nonatomic , strong)UITableView *articleTableView;
@property (nonatomic , strong)NSArray <NSString *>*paragraphsArray;
@property (nonatomic , strong)NSString *prevDate;
@property (nonatomic , strong)ArticleViewModel *articleViewModel;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.type == ArticleSourceTypeToday?@"今日美文":(self.type == ArticleSourceTypeDate?@"昨日美文":@"美文");
    [self setupNavigationItems];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.articleTableView];
    
    [self bindViewModel];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    self.articleTableView.frame = self.view.bounds;
}


#pragma mark -- private method
- (void)setupNavigationItems{
    if (self.type == ArticleSourceTypeToday) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 50, 20);
        [leftButton setTitle:@"昨日美文" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [leftButton addTarget:self action:@selector(yestodayArticleAction) forControlEvents:UIControlEventTouchUpInside];
        UIView *leftView = [[UIView alloc] initWithFrame:leftButton.bounds];
        [leftView addSubview:leftButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 50, 20);
        [rightButton setTitle:@"随机美文" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [rightButton addTarget:self action:@selector(randomArticleAction) forControlEvents:UIControlEventTouchUpInside];
        UIView *rightView = [[UIView alloc] initWithFrame:rightButton.bounds];
        [rightView addSubview:rightButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    }
    
}


- (void)bindViewModel{
    
    /*
     
     date：日期
     curr：今日日期，yyyyMMdd 格式
     prev：昨日日期，yyyyMMdd 格式
     next：明日日期，yyyyMMdd 格式
     author：作者
     titile：标题
     digest：首段
     content：正文内容
     wc：字数(word count)
     
     
     "date": {
     "curr": "20180913",
     "prev": "20180912",
     "next": "20180914"
     },
     "author": "森克纳",
     "title": "一角钱的玫瑰花",
     "digest": "博贝坐在后院的雪地里，感到身上越来越冷。他已经呆了一个小时了，却无论如何也想不出该给妈妈送什么礼物。自从五年前爸爸去世以后，一家五口只好勉强",
     "content": "<p>博贝坐在后院的雪地里，感到身上越来越冷。他已经呆了一个小时了，却无论如何也想不出该给妈妈送什么礼物。自从五年前爸爸去世以后，一家五口只好勉强度日。虽然家境贫寒，但这并不能削弱一家人彼此相爱。博贝有两个姐姐和一个妹妹，她们手巧，都已经给妈妈制作了漂亮的礼物。不知怎么的，博贝感到很委屈。现在已经是圣诞节前夕了，他还两手空空呢。</p><p>博贝拭去了脸上的一滴眼泪，开始向着两边布满了大小商店的街上走去。天色就要黑下来了，博贝无奈地转身回家。就在这时，他的眼睛一下看到有个什么东西在晚霞中闪光。他蹲下身来，发现那是一枚小小的一角钱的硬币。</p><p>没有人能像博贝捡起那枚硬币时感觉到那么富有。随后他就走进了眼前的一家商店。当售货员告诉他说一角钱什么也买不了的时候，他那颗激动的心很快就凉了下来。</p><p>他还是走进了一家花店。店主人问他要买什么东西的时候，他掏出了那一角钱，问能不能买一朵花，当作圣诞礼物送给妈妈。店主人看看博贝，又看看他手里的一角钱，说：“你就在这里等着，我去想想办法。”</p><p>过了很久，店主人出来了。啊！博贝眼前摆放着十二朵鲜红的玫瑰花，那些花带着绿绿的叶子还有长长的枝条，用一个银环跟一些小白花束在一起。店主人把花束拿起来，却把它轻轻地放进了一个长长的白色盒子里。博贝看着，心顿时凉了。</p><p>“小伙子，这个卖一角钱。”店主人一边说，一边伸手向他要那一角钱。博贝的手慢慢地移动着，把那一角钱交给店主人。这是真的吗？一角钱，人家不是说什么都买不到的吗？店主人察觉到了博贝的疑虑，说：“我碰巧要贱卖一些玫瑰花。你看那些花漂亮吗？”</p><p>博贝不再犹豫了。店主人把那个盒子送到他的手里的时候，他知道那不是一个梦。他听到店主人在身后说：“圣诞快乐，孩子。”</p><p>店主人的妻子出来了。“你在那儿跟谁说话呢？你收拾好的花呢？”</p><p>店主人看着窗外，眼睛里含着眼泪说：“今天早晨我碰到了一件奇怪的事情。我在摆放货物准备开门的时候，好像听到有个声音跟我说话，叫我留下十二朵最漂亮的玫瑰花，当作一个特殊的礼物。那时我搞不清是我走神了还是怎么的。不过我还是把花留下了。后来，也就是刚才，一个小男孩进来了，他想用一角钱给他的妈妈买一朵花。看见了他，我好像看见了好多年前的我自己。那个时候我也是一个穷孩子，也没有一分钱给妈妈买礼物。我在街上走着的时候，一个我从来没有见过面的大胡子叫住了我，他说他要给我十块钱。今天晚上我一看见那个孩子，就明白了那声音说的是谁了。我挑选了十二朵最最漂亮的玫瑰花。”</p><p>店主人和妻子紧紧地拥抱着。他们觉得他们得到了最好的圣诞礼物。</p>",
     "wc": 1042
     }
     
     */
    
    [self.articleViewModel.articleCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //x为网络请求的回调结果,可以在这里对x做处理,修改UI
        NSString *content = x[@"content"];
        self.titleView.artilceTitle = x[@"title"];
        self.titleView.articleAuthor = x[@"author"];
        self.prevDate = x[@"date"][@"prev"];
        
        NSArray *paragraphsArray = [content componentsSeparatedByString:@"</p>"];
        NSMutableArray *tmpParagraphsArray = [[NSMutableArray alloc] init];
        for (NSString *paragraph in paragraphsArray) {
            NSArray *tmpArrays = [paragraph componentsSeparatedByString:@"<p>"];
            if (![tmpArrays.lastObject isEqualToString:@""]) {
                //段首空格
                [tmpParagraphsArray addObject:[NSString stringWithFormat:@"        %@",tmpArrays.lastObject]];
            }
        }
        self.paragraphsArray = tmpParagraphsArray;
        [self.articleTableView reloadData];
        

    }];
    
    //注意:我们不应该使用subscribeError:这个方法取订阅错误信号,因为executionSignals这个信号是不会发送error事件的.所以需使用subscribeNext:订阅错误信号
    [self.articleViewModel.articleCommand.errors subscribeNext:^(NSError *error) {
    }];
    //如果有日期就是日期当天的文章，否则就是今天的文章
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"type"] = @(self.type);
    dict[@"date"] = self.date;
    [self.articleViewModel.articleCommand execute:dict];
}

#pragma mark -- event response
- (void)yestodayArticleAction{
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    articleVC.type = ArticleSourceTypeDate;
    articleVC.date = self.prevDate;
    [self.navigationController pushViewController:articleVC animated:YES];
}

- (void)randomArticleAction{
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    articleVC.type = ArticleSourceTypeRandom;
    [self.navigationController pushViewController:articleVC animated:YES];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paragraphsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    ParagraphCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ParagraphCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.paragraph = self.paragraphsArray[indexPath.row];
    return cell;
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *paragraph = self.paragraphsArray[indexPath.row];
    CGSize maxSize = CGSizeMake(self.view.bounds.size.width - 20, MAXFLOAT);
    CGRect rect = [paragraph boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kParagraphCellLabelFontSize]} context:nil];
    return 10 + rect.size.height;
}

#pragma mark -- getters and setters
- (UITableView *)articleTableView{
    if (_articleTableView == nil) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _articleTableView.backgroundColor = [UIColor whiteColor];
        _articleTableView.dataSource = self;
        _articleTableView.delegate = self;
        _articleTableView.tableFooterView = [[UIView alloc] init];
        _articleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _articleTableView.tableHeaderView = self.titleView;
    }
    return _articleTableView;
}

- (ArticleTitleView *)titleView{
    if (_titleView == nil) {
        _titleView = [[ArticleTitleView alloc] init];
    }
    return _titleView;
}

- (ArticleViewModel *)articleViewModel{
    if (_articleViewModel == nil) {
        _articleViewModel = [[ArticleViewModel alloc] init];
    }
    return _articleViewModel;
}



@end
