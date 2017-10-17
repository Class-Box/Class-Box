//
//  MainUserMsgController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MainUserMsgController.h"
#import "DiscoverUserMsgCell.h"
#import "MASConstraintMaker.h"

@interface MainUserMsgController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy)NSArray *userArray;

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation MainUserMsgController

- (instancetype)initWithTitle:(NSString *)title userModelArray:(NSArray *)userArray {
    if (self = [super init]) {
        [self setTitle:title];
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerClass:[DiscoverUserMsgCell class] forCellReuseIdentifier:@"userCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverUserMsgCell *cell = (DiscoverUserMsgCell *) [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!cell) {
        cell = [[DiscoverUserMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
