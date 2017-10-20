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
#import "NoteModel.h"
#import "NetworkTool.h"
#import "MJExtension.h"
#import "UserDefaults.h"

@interface DiscoverClassExchangeCtrl()<UITableViewDelegate, UITableViewDataSource, DiscoverMainCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray <NoteModel *> *noteArray;

@end

@implementation DiscoverClassExchangeCtrl {

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
    [self setTitle:@"班级圈"];
    [self setUpNavigationBar];
    [self setUpView];
    [self.tableView.mj_header beginRefreshing];
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self setRefresh];
}

- (void)classmateButtonClick {
    DiscoverClassmateCtrl *classmateCtrl = [[DiscoverClassmateCtrl alloc] initWithClassId:@1];
    [self.navigationController pushViewController:classmateCtrl animated:YES];
}

//设置刷新
- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
//加载最新数据
- (void)loadNewData {
    [[NetworkTool sharedNetworkTool] loadDataInfo:[LIST_CLASSMATE_NOTE_APT stringByAppendingFormat:@"/%@/classes/%@/notes", [UserDefaults getUserId], [UserDefaults getUserClassId]] parameters:nil success:^(id responseObject) {
        NSArray *records = responseObject[@"result"][@"records"];
        self.noteArray = [NoteModel mj_objectArrayWithKeyValuesArray:records];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
    [self.tableView.header endRefreshing];

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
- (void)commentButtonClick {
    [self.navigationController pushViewController:[[DiscoverCommentController alloc] init] animated:YES];
}

- (void)userMsgClick {
    [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
}
@end
