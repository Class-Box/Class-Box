//
//  DiscoverPostController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/17.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverPostController.h"

@implementation DiscoverPostController {
    UITextView *_commentTextView;
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpView {
    _commentTextView = [[UITextView alloc] init];
    _commentTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentTextView];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).offset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
    }];
}
@end
