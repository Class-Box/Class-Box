//
//  DiscoverClassExchangeCtrl.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverClassExchangeCtrl.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverCommentController.h"
#import "DiscoverUserCenterController.h"
#import "DiscoverClassmateCtrl.h"

@interface DiscoverClassExchangeCtrl()<UITableViewDelegate, UITableViewDataSource, DiscoverMainCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation DiscoverClassExchangeCtrl {

}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"班级圈"];
    [self setUpNavigationBar];
    [self setUpView];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)setUpNavigationBar {
    UIBarButtonItem *classmateItem = [[UIBarButtonItem alloc] initWithTitle:@"班级成员" style:UIBarButtonItemStylePlain target:self action:@selector(classmateButtonClick)];
    self.navigationItem.rightBarButtonItem = classmateItem;
}
- (void)setUpView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerClass:[DiscoverMainCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 400;
    [self setRefresh];
}

- (void)classmateButtonClick {
    [self.navigationController pushViewController:[[DiscoverClassmateCtrl alloc] init] animated:YES];
}

//设置刷新
- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
//加载最新数据
- (void)loadNewData {
    [self.tableView.header endRefreshing];
}

- (void)loadMoreData {
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - TableView Delegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverMainCell *cell = (DiscoverMainCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DiscoverMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    DiscoverMainCellModel *model = [[DiscoverMainCellModel alloc] init];
    model.portrait = [UIImage imageNamed:@"People"];
    model.userName = @"张力明";
    model.content = @"这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear";
    model.imageArray = @[@"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad"];
    model.publishDate = [[NSDate alloc] init];
    model.courseName = @"Java开发";
    [cell setModel:model];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edg = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.separatorInset = edg;
}


#pragma mark - DiscoverMainCellDelegate
- (void)commentButtonClick {
    [self.navigationController pushViewController:[[DiscoverCommentController alloc] init] animated:YES];
}

- (void)userMsgClick {
    [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
}
@end
