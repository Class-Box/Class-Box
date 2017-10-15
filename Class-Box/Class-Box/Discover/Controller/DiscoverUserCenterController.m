//
//  DiscoverUserCenterController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "DiscoverUserCenterController.h"
#import "JSHeaderView.h"
#import "View+MASAdditions.h"
#import "UserInfoCell.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverCommentController.h"

@interface DiscoverUserCenterController()<UITableViewDelegate, UITableViewDataSource, DiscoverMainCellDelegate>

@property (nonatomic, strong) JSHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DiscoverUserCenterController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark - UITableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if (!cell) {
            cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        }
        return cell;
    } else {
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
- (void)commentButtonClick {
    [self.navigationController pushViewController:[[DiscoverCommentController alloc] init] animated:YES];
}

- (void)userMsgClick {
    [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
}
@end
