//
//  DiscoverCommentController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverCommentController.h"
#import "DiscoverCommentCell.h"
#import "DiscoverUserCenterController.h"
#import "DiscoverPostController.h"
#import "NetworkTool.h"
#import "NoteModel.h"
#import "MJExtension.h"
#import "NoteCommentModel.h"

@interface DiscoverCommentController()<UITableViewDataSource, UITableViewDelegate, DiscoverCommentCellDelegate>

@property (nonatomic, copy)NSArray <NoteCommentModel *> *commentModelArray;
@end

@implementation DiscoverCommentController {
    NSNumber *_noteId;
}

#pragma mark - 懒加载
- (NSArray<NoteCommentModel *> *)commentModelArray {
    if (_commentModelArray) {
        _commentModelArray = [NSArray array];
    }
    return _commentModelArray;
}
- (instancetype)initWithNoteId:(NSNumber *)noteId {
    if (self = [super init]) {
        _noteId = noteId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self loadData];
}

- (void)setUpView {
    self.title = @"评论";

    UIBarButtonItem *pushBarButton = [[UIBarButtonItem alloc] initWithTitle:@"添加评论" style:UIBarButtonItemStylePlain target:self action:@selector(pushCommentButtonClick)];
    self.navigationItem.rightBarButtonItem = pushBarButton;

    [self.tableView registerClass:[DiscoverCommentCell class] forCellReuseIdentifier:@"commentCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
}

- (void)loadData {
    [[NetworkTool sharedNetworkTool] loadDataInfo:LIST_NOTE_COMMNENT  parameters:@{@"note_id" : _noteId} success:^(id responseObject) {
        NSArray *commentArray = responseObject[@"comments"];
        NSArray <NoteCommentModel * > *noteModelArray = [NoteCommentModel mj_objectArrayWithKeyValuesArray:commentArray];
        self.commentModelArray = noteModelArray;
    } failure:^(NSError *error) {

    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)pushCommentButtonClick {
    DiscoverPostController *postController = [[DiscoverPostController alloc] init];
    [self presentViewController:postController animated:YES completion:nil];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (!cell) {
        cell = [[DiscoverCommentCell alloc] init];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NoteCommentModel *model = self.commentModelArray[indexPath.row];
    [cell setMsgWithUserName:model.commenter image:nil content:model.content];
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
