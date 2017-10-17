//
//  MainPatchMsgController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/17.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MainPatchMsgController.h"

@interface MainPatchMsgController()

@property (nonatomic, copy)NSString *defaultText;
@property (nonatomic, copy)NSString *key;
@end

@implementation MainPatchMsgController {
    UITextField *_mainTextField;
}

- (instancetype)initWithTitle:(NSString *)title withDefaultText:(NSString *)defaultText key:(NSString *)key {
    if (self = [super init]) {
        [self setTitle:title];
        self.defaultText = defaultText;
        self.key = key;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];

}

- (void)setUpNavigationBar {
    UIBarButtonItem *completeButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeButtonClick)];
    self.navigationItem.rightBarButtonItem = completeButton;
}


- (void)completeButtonClick {
    if ([_mainTextField.text isEqualToString:@""]) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
    }else if ([_mainTextField.text isEqualToString:self.defaultText]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        if (_delegate) {
            [_delegate completeButtonClickWithText:_mainTextField.text andKey:self.key];
        }
    }
}

- (void)setUpView {
    _mainTextField = [[UITextField alloc] init];
    _mainTextField.backgroundColor = [UIColor whiteColor];
    _mainTextField.text = self.defaultText;
    _mainTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_mainTextField];
    [_mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.width.mas_equalTo(S_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self.view endEditing:YES];
}
@end
