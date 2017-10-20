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
#import "NetworkTool.h"
#import "UserDefaults.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface PublishViewController()<HXPhotoViewDelegate, UITextViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic)UITextField *courseTextField;
@end

@implementation PublishViewController{
    UILabel *_placeholderLabel;
    NSMutableArray <NSData *> *_imageData;
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
    if ([_textView.text isEqualToString:@""]) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        [SVProgressHUD showErrorWithStatus:@"请输入内容！"];
    } else if ([_courseTextField.text isEqualToString:@""]) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        [SVProgressHUD showErrorWithStatus:@"请输入课程名称！"];
    } else {
        [[NetworkTool sharedNetworkTool] loadDataInfoWithImage:POST_NOTE_API parameters:@{
                @"user_id" : [UserDefaults getUserId],
                @"content" : _textView.text,
                @"course_name" : _courseTextField.text,
        } imageData:_imageData.firstObject success:^(id responseObject) {
            NSLog(@"%@", responseObject);
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
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

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 155, S_WIDTH - 2 * kPhotoViewMargin, 1)];
    lineView.backgroundColor = RGB_COLOR(230, 230, 230);
    [scrollView addSubview:lineView];

    UILabel *courseTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 160, S_WIDTH, 30)];
    courseTitleLabel.text = @"该笔记相关的课程:";
    courseTitleLabel.font = [UIFont systemFontOfSize:18];
    [scrollView addSubview:courseTitleLabel];

    _courseTextField = [[UITextField alloc] initWithFrame:CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 200, S_WIDTH - 2 * kPhotoViewMargin, 50)];
    _courseTextField.placeholder = @"请输入该笔记的课程";
    _courseTextField.layer.borderWidth = 0.5;
    _courseTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _courseTextField.font = [UIFont systemFontOfSize:25];
    _courseTextField.backgroundColor = RGB_COLOR(230, 230, 230);
    [scrollView addSubview:_courseTextField];

    _manager = [[HXPhotoManager alloc] init];
    _manager.photoMaxNum = 1;
    _photoView = [HXPhotoView photoManager:_manager];
    _photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 260, width - kPhotoViewMargin * 2, 0);
    _photoView.delegate = self;
    _photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:_photoView];
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
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        _imageData = [NSMutableArray array];
        // 获取imageData - 通过相册获取时有用 / 通过相机拍摄的无效
        [HXPhotoTools FetchPhotoDataForPHAsset:model.asset completion:^(NSData *imageData, NSDictionary *info) {
            [_imageData addObject:imageData];
        }];

    }];
}
@end
