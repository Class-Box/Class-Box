//
//  DiscoverUserCenterController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <MJExtension/MJExtension.h>
#import "DiscoverUserCenterController.h"
#import "JSHeaderView.h"
#import "View+MASAdditions.h"
#import "UserInfoCell.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverCommentController.h"
#import "NetworkTool.h"
#import "UserDefaults.h"
#import "NoteModel.h"

@interface DiscoverUserCenterController()<UITableViewDelegate, UITableViewDataSource, DiscoverMainCellDelegate>

@property (nonatomic, strong) JSHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) User* userModel;
@property (nonatomic, copy) NSArray <NoteModel *> *noteModelArray;
@end

@implementation DiscoverUserCenterController {
    NSNumber *_userId;
}

- (instancetype)initWithUserId:(NSNumber *)userId {
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

#pragma mark -懒加载
- (User *)userModel {
    if (!_userModel) {
        _userModel = [[User alloc] init];
    }
    return _userModel;
}

- (NSArray<NoteModel *> *)_noteModelArray {
    if (!_noteModelArray) {
        _noteModelArray = [NSArray array];
    }
    return _noteModelArray;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark - 初始化
- (void)setUpView {
    _tableView = [[UITableView alloc] init];
    _tableView.estimatedRowHeight = 400;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[DiscoverMainCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:@"userCell"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.headerView = [[JSHeaderView alloc] initWithImage:[UIImage imageNamed:@"People"]];
    [self.headerView reloadSizeWithScrollView:_tableView];
    self.navigationItem.titleView = self.headerView;
}


- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)loadData {
    [[NetworkTool sharedNetworkTool] loadDataInfo:[USER_MSG_API stringByAppendingFormat:@"/%@", _userId] parameters:@{
                    @"user_id" : [UserDefaults getUserId]
            }
                                                                                                                        success:^(id responseObject) {
                                                                                                                            NSArray <User *> *userArray = [User mj_objectArrayWithKeyValuesArray:responseObject[@"user"]];
                                                                                                                            self.userModel = userArray.firstObject;
                                                                                                                            [self.tableView reloadData];
                                                                                                                        } failure:^(NSError *error) {

            }];

    [[NetworkTool sharedNetworkTool] loadDataInfo:POST_NOTE_API parameters:@{
            @"user_id" : _userId
    } success:^(id responseObject) {
        self.noteModelArray = [NoteModel mj_objectArrayWithKeyValuesArray:responseObject[@"notes"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

#pragma mark - UITableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteModelArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if (!cell) {
            cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        }
        [cell setUserModel:_userModel];
        return cell;
    } else {
        DiscoverMainCell *cell = (DiscoverMainCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[DiscoverMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NoteModel *noteModel = self.noteModelArray[indexPath.row-1];

        DiscoverMainCellModel *model = [[DiscoverMainCellModel alloc] init];
        model.portrait = [UIImage imageNamed:@"People"];
        model.userName = self.userModel.username;
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
        [cell cancelGestureRecognizer];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
