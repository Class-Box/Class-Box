//
//  MianNoteController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "NoteModel.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverCommentController.h"
#import "DiscoverUserCenterController.h"
#import "MainNoteController.h"

@interface MainNoteController()<UITableViewDataSource, UITableViewDelegate, DiscoverMainCellDelegate>

@property (nonatomic, copy)NSArray <NoteModel *>*noteArray;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MainNoteController

- (instancetype)initWithTitle:(NSString *)title noteModelArray:(NSArray <NoteModel *> *)noteArray {
    if (self = [super init]) {
        [self setTitle:title];
        self.noteArray = noteArray;
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
    self.tableView.estimatedRowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    [self.tableView registerClass:[DiscoverMainCell class] forCellReuseIdentifier:@"noteCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
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
