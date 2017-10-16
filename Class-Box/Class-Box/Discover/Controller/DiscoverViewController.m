//
//  DiscoverViewController.m
//  ClassBox
//
//  Created by sherlock on 2017/9/16.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverSearchViewController.h"
#import "DiscoverCommentController.h"
#import "DiscoverUserCenterController.h"

@interface DiscoverViewController ()<DiscoverMainCellDelegate>

@end

@implementation DiscoverViewController{

}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - 初始化
- (void)setUpView {
    [self setUpNavigationBar];
    [self setUpTableView];
    [self setRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)setUpNavigationBar {
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClick)];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)searchBtnClick {
    DiscoverSearchViewController *searchViewController = [[DiscoverSearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)setUpTableView {
    [self.tableView registerClass:[DiscoverMainCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 400;
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
