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
#import "DiscoverClassExchangeCtrl.h"
#import "NetworkTool.h"
#import "UserDefaults.h"
#import "NoteModel.h"
#import <MJExtension/MJExtension.h>

@interface DiscoverViewController ()<DiscoverMainCellDelegate>

@property (nonatomic, copy)NSArray <NoteModel *> *noteArray;

@end

@implementation DiscoverViewController{

}
#pragma mark - 懒加载
- (NSArray <NoteModel *>*)noteArray {
    if (!_noteArray) {
        _noteArray = [NSArray array];
    }
    return _noteArray;
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
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)setUpNavigationBar {
    UIBarButtonItem *classItem = [[UIBarButtonItem alloc] initWithTitle:@"班级圈" style:UIBarButtonItemStylePlain target:self action:@selector(classButtonClick)];
    self.navigationItem.leftBarButtonItem = classItem;

    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClick)];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)classButtonClick {
    [self.navigationController pushViewController:[[DiscoverClassExchangeCtrl alloc] init] animated:YES];
}

- (void)searchBtnClick {
    DiscoverSearchViewController *searchViewController = [[DiscoverSearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)setUpTableView {
    [self.tableView registerClass:[DiscoverMainCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

//设置刷新
- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//加载最新数据
- (void)loadNewData {
    [[NetworkTool sharedNetworkTool] loadDataInfo:[FOLLOWING_NOTE_API stringByAppendingFormat:@"/%@/notes", [UserDefaults getUserId] ] parameters:@{
            @"sorter" :@"created_at",
            @"order" : @"desc"
    } success:^(id responseObject) {
        NSArray *records = responseObject[@"notes"][@"records"];
        self.noteArray = [NoteModel mj_objectArrayWithKeyValuesArray:records];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
    [self.tableView.header endRefreshing];
}

- (void)loadMoreData {
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - TableView Delegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverMainCell *cell = (DiscoverMainCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DiscoverMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NoteModel *noteModel = self.noteArray[indexPath.row];

    DiscoverMainCellModel *model = [[DiscoverMainCellModel alloc] init];
    model.portrait = [UIImage imageNamed:@"People"];
    model.userName = noteModel.author;
    model.content = noteModel.content;
    model.publishDate = noteModel.createdAt;
    model.courseName = noteModel.courseName;
    model.noteId = noteModel.id;
    model.likeId = noteModel.likeId;
    model.userId = noteModel.authorId;
    model.collectId = noteModel.iscollected;
    if (noteModel.imgs) {
        model.img = noteModel.imgs;
    }
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
- (void)commentButtonClick:(NSNumber *)noteId {
    [self.navigationController pushViewController:[[DiscoverCommentController alloc] initWithNoteId:noteId] animated:YES];
}

- (void)userMsgClick:(NSNumber *)userId {
    DiscoverUserCenterController *userCenterController = [[DiscoverUserCenterController alloc] initWithUserId:userId];
    [self.navigationController pushViewController:userCenterController animated:YES];
}
@end
