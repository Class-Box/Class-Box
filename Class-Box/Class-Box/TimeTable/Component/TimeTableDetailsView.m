//
//  TimeTableDetailsView.m
//  Class-Box
//
//  Created by sherlock on 2017/9/25.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableDetailsView.h"
#import "Masonry.h"

#define random(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface TimeTableDetailsView ()

@property(nonatomic)UIView *weekdaysView;

@property(nonatomic, weak)UIView *selectedView;

//@property(nonatomic, strong)UIView *lineView;

@property(nonatomic)NSMutableArray <UIButton *>*classButtons;

@property(nonatomic)NSMutableDictionary<NSValue *, UIColor *> *colorMap;

@end

@implementation TimeTableDetailsView

#pragma mark system

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createLines];
        [self initViews];
        [self initConstraints];
        self.colorMap = [NSMutableDictionary dictionary];
        self.classButtons = [NSMutableArray new];
//        [self createButtonView:nil];
        
        NSDate *date = NSDate.new;
        NSArray *weekdayAry = [NSArray arrayWithObjects:@"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat  setShortWeekdaySymbols:weekdayAry];
        [dateFormat setDateFormat:@"eee"];
        NSInteger index = [dateFormat stringFromDate:date].integerValue;
        [self weekdaysClicked:[self.weekdaysView viewWithTag:index].subviews.firstObject];
        [((UIButton *)self.selectedView.subviews.firstObject) setTitleColor:MAIN_TONE_COLOR forState:UIControlStateNormal];
    }
    return self;
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
    
//    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, SECTIONHEIGHT - 1, SINGLETABWIDTH * 2, 1)];
//    self.lineView.backgroundColor = MAIN_TONE_COLOR;
    
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

- (void)reloadData:(NSArray <Timetable *>*)data {
    [self.classButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (Timetable *model in data) {
        CGPoint place = model.place;
        NSInteger rowspan = model.rowspan;
        
        UIColor *color;
        if (rowspan == 2) {
            color = randomColor;
            self.colorMap[[NSValue valueWithCGPoint:place]] = color;
        } else if (rowspan == 1) {
            CGPoint location = CGPointMake(place.x - 2, place.y);
            color = self.colorMap[[NSValue valueWithCGPoint:location]];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = color;
        [self addSubview:btn];
        if (rowspan == 2) {
            [btn setTitle:model.content forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            btn.titleLabel.numberOfLines = 0;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.leading.mas_equalTo( [self.weekdaysView viewWithTag:(NSInteger)(place.y + 1)] );
            make.height.mas_equalTo(SECTIONHEIGHT * rowspan);
            make.top.mas_equalTo(self.weekdaysView.mas_bottom).offset(SECTIONHEIGHT * (place.x - 1));
        }];
        [self.classButtons addObject:btn];
    }
    
}

//创建课程的view 按钮
- (void)createButtonView:(Timetable *)model {
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
//    [((UIButton *)self.selectedView.subviews.firstObject) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SINGLETABWIDTH * 2, SECTIONHEIGHT));
    }];
    self.selectedView = sender.superview;
//    [((UIButton *)self.selectedView.subviews.firstObject) setTitleColor:MAIN_TONE_COLOR forState:UIControlStateNormal];
}

@end
