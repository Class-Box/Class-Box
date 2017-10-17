//
//  DiscoverCommentController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "DiscoverCommentController.h"
#import "DiscoverCommentCell.h"
#import "DiscoverUserCenterController.h"

@interface DiscoverCommentController()<UITableViewDataSource, UITableViewDelegate, DiscoverCommentCellDelegate>

@end

@implementation DiscoverCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    self.title = @"评论";
    [self.tableView registerClass:[DiscoverCommentCell class] forCellReuseIdentifier:@"commentCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (!cell) {
        cell = [[DiscoverCommentCell alloc] init];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMsgWithUserName:@"张力明" image:nil content:@"内容"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edg = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.separatorInset = edg;
}

#pragma mark - DiscoverCommentCellDelegate
- (void)moveToUser {
    [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
}
@end
