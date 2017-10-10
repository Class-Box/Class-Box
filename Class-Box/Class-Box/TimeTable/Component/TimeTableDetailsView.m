//
//  TimeTableDetailsView.m
//  Class-Box
//
//  Created by sherlock on 2017/9/25.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableDetailsView.h"
#import "Masonry.h"

@interface TimeTableDetailsView ()

@property(nonatomic)UIView *weekdaysView;

@property(nonatomic, weak)UIView *selectedView;

@end

@implementation TimeTableDetailsView

#pragma mark system

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createLines];
        [self initViews];
        [self initConstraints];
        
        [self createButtonView:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark custom

- (void)createLines {
    for (NSInteger i = 0; i < SECTIONNUMBER + 1; i++) {
        CALayer *lineLayer = [CALayer layer];
        lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        lineLayer.frame = CGRectMake(0, (i + 1) * SECTIONHEIGHT, SCROLLVIEWWIDTH , 0.5f);
        [self.layer addSublayer:lineLayer];
    }
}

- (void)createButtonWithTitle:(NSString *)title tintColor:(UIColor *)color superView:(UIView *)view selector:(SEL)selector tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    [self.weekdaysView addSubview:view];
    view.tag = tag;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
}

- (void)initViews {
    self.weekdaysView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCROLLVIEWWIDTH, SECTIONHEIGHT)];
    [self addSubview:self.weekdaysView];
    [self createButtonWithTitle:@"星期一" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:1];
    [self createButtonWithTitle:@"星期二" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:2];
    [self createButtonWithTitle:@"星期三" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:3];
    [self createButtonWithTitle:@"星期四" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:4];
    [self createButtonWithTitle:@"星期五" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:5];
    [self createButtonWithTitle:@"星期六" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:6];
    [self createButtonWithTitle:@"星期日" tintColor:[UIColor blackColor] superView:UIView.new selector:@selector(weekdaysClicked:) tag:7];
}

- (void)initConstraints {
    UIView *button;
    button = [self.weekdaysView viewWithTag:1];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.weekdaysView).offset(TRANSLUCENTVIEWWIDTH);
        make.top.mas_equalTo(self.weekdaysView);
        make.size.mas_equalTo(CGSizeMake(SINGLETABWIDTH * 2, SECTIONHEIGHT));
    }];
    self.selectedView = button;
    for (NSInteger i = 2; i < 8; i++) {
        UIView *current = [self.weekdaysView viewWithTag:i];
        [current mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SINGLETABWIDTH, SECTIONHEIGHT));
            make.top.mas_equalTo(button);
            make.leading.mas_equalTo(button.mas_trailing);
        }];
        button = current;
    }
}

//创建课程的view 按钮
- (void)createButtonView:(id)model {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColor.orangeColor;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.leading.mas_equalTo([self.weekdaysView viewWithTag:1]);
        make.height.mas_equalTo(SECTIONHEIGHT * 2);
        make.top.mas_equalTo(self.weekdaysView.mas_bottom).offset(0);
    }];
}

#pragma mark target function

- (void)weekdaysClicked:(UIButton *)sender {
    [self.selectedView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SINGLETABWIDTH, SECTIONHEIGHT));
    }];
    [sender.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SINGLETABWIDTH * 2, SECTIONHEIGHT));
    }];
    self.selectedView = sender.superview;
}

@end
