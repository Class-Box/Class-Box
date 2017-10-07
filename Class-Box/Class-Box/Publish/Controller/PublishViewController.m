//
//  PublishViewController.m
//  ClassBox
//
//  Created by Wrappers Zhang on 2017/9/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PublishViewController.h"
#import "HXPhotoManager.h"
#import "HXPhotoView.h"
#import "HXPhotoViewController.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface PublishViewController()<HXPhotoViewDelegate, UITextViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextView *textView;

@end

@implementation PublishViewController{
    UILabel *_placeholderLabel;
}

#pragma mark - 懒加载
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    }
    return _manager;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpView];
}

#pragma mark - 初始化
- (void)setUpNavigationBar {
    [self setTitle:@"发布新笔记"];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    [leftBarButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    [rightBarButton setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)backBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;

    CGFloat width = scrollView.frame.size.width;

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 0, width - kPhotoViewMargin * 2, 150)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:16];
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.font = [UIFont systemFontOfSize:16];
    _placeholderLabel.text = @"分享点什么吧";
    [textView addSubview:_placeholderLabel];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_top).offset(8);
        make.leading.mas_equalTo(textView.mas_leading).offset(5);
    }];
    self.textView = textView;
    self.textView.delegate = self;
    [scrollView addSubview:textView];

    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 160, width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
}


#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView {

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 20;// 字体的行间距
    NSDictionary *attributes = @{
            NSFontAttributeName:[UIFont systemFontOfSize:15],
            NSParagraphStyleAttributeName:paragraphStyle
    };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}


#pragma mark - UIScrollView
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self.view endEditing:YES];
}

#pragma mark - HXPhotoViewDelegate
// 代理返回 选择、移动顺序、删除之后的图片以及视频
- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal {

}
@end
