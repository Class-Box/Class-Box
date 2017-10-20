//
//  DiscoverPostController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/17.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverPostController.h"
#import "NetworkTool.h"
#import "UserDefaults.h"

@implementation DiscoverPostController {
    UITextView *_commentTextView;
    NSNumber *_noteId;
}

- (instancetype)initWithNoteId:(NSNumber *)noteId {
    if (self = [super init]) {
        _noteId = noteId;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布评论";
    [self setNavigationBar];
    [self setUpView];
}

- (void)setNavigationBar {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeButtonClick)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)completeButtonClick {
    [[NetworkTool sharedNetworkTool] jsonPOST:POST_NOTE parameters:@{
            @"user_id" : [UserDefaults getUserId],
            @"note_id" : _noteId,
            @"content" : _commentTextView.text
    } success:^(id responseObject) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showSuccessWithStatus:@"评论成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"评论失败!"];
    }];
}

- (void)setUpView {
    _commentTextView = [[UITextView alloc] init];
    _commentTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentTextView];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
    }];
}
@end
