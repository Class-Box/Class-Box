//
//  DiscoverClassmateCtrl.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverClassmateCtrl.h"
#import "DiscoverUserMsgCell.h"
#import "NetworkTool.h"
#import "UserDefaults.h"
#import "MJExtension.h"

@interface DiscoverClassmateCtrl()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)NSArray <User *> *classmatesArray;

@end

@implementation DiscoverClassmateCtrl {
    NSNumber *_classId;
}

- (instancetype)initWithClassId:(NSNumber *)classId {
    if (self = [super init]) {
        _classId = classId;
    }
    return self;
}

#pragma mark - 懒加载
- (NSArray<User *> *)classmatesArray {
    if (!_classmatesArray) {
        _classmatesArray = [NSArray array];
    }
    return _classmatesArray;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUpView];
    [self setUpRefresh];
    [self.tableView.mj_header beginRefreshing];
}


- (void)setNavigationBar {
    [self setTitle:@"软件工程142班"];
}

- (void)setUpView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[DiscoverUserMsgCell class] forCellReuseIdentifier:@"userCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
}

- (void)reloadData {
    [[NetworkTool sharedNetworkTool] loadDataInfo:LIST_CLASSMATE_API parameters:@{@"class_id" : _classId} success:^(id responseObject) {
        NSArray *userArray = responseObject[@"result"][@"records"];
        NSMutableArray <User *> *userModelArray = [User mj_objectArrayWithKeyValuesArray:userArray];
        for (int i = 0; i < userModelArray.count; ++i) {
            if ([userModelArray[i].id isEqualToNumber:[UserDefaults getUserId]]) {
                [userModelArray removeObjectAtIndex:i];
                break;
            }
        }
        self.classmatesArray = userModelArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classmatesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     DiscoverUserMsgCell *cell = (DiscoverUserMsgCell *) [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!cell) {
        cell = [[DiscoverUserMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
    }
    User *user = self.classmatesArray[indexPath.row];
    [cell setUserModel:user];
    return cell;
}
@end
