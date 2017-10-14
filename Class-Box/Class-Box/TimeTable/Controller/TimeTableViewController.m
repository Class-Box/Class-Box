//
//  TimeTableViewController.m
//  ClassBox
//
//  Created by Wrappers Zhang on 2017/9/16.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableViewController.h"
#import "Masonry.h"
#import "TimeTableDetailsView.h"
#import "ExamViewController.h"
#import "TimeTableDiscoverViewController.h"
#import "SchoolLoginViewController.h"

@interface TimeTableViewController ()

@property(nonatomic) UIScrollView *scrollView;
@property(nonatomic) UIVisualEffectView *effectView;
@property(nonatomic) TimeTableDetailsView *detailsView;
@property(nonatomic) Boolean isFirst;

@end

@implementation TimeTableViewController

#pragma mark system

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"考试" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询课程" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClicked)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"第一周" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isFirst) {
        _isFirst = YES;
        SchoolLoginViewController *svc = [SchoolLoginViewController new];
        [self presentViewController:svc animated:YES completion:nil];
    }
}

#pragma mark mark initView

- (void)initViews {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT)];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCROLLVIEWWIDTH, SECTIONHEIGHT * (SECTIONNUMBER + 1));
    [self.view addSubview:self.scrollView];
    
    TimeTableDetailsView *detailsView = [[TimeTableDetailsView alloc] initWithFrame:CGRectMake(0, 0, SCROLLVIEWWIDTH, SECTIONHEIGHT * (SECTIONNUMBER + 1))];
    self.detailsView = detailsView;
    [self.scrollView addSubview:detailsView];
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.scrollView addSubview:self.effectView];
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scrollView);
        make.size.sizeOffset(CGSizeMake(TRANSLUCENTVIEWWIDTH, SECTIONHEIGHT * (SECTIONNUMBER + 1)));
    }];
    
    NSString *path= [NSBundle.mainBundle pathForResource:@"ClassTime" ofType:@"plist"];
    NSArray *temp = [NSArray arrayWithContentsOfFile:path];
    for (NSInteger i = 0; i < SECTIONNUMBER; i++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, (i + 1) * SECTIONHEIGHT, TRANSLUCENTVIEWWIDTH, SECTIONHEIGHT);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%ld \n%@",i + 1,temp[i]];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(view);
        }];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        layer.frame = CGRectMake(0, 0, TRANSLUCENTVIEWWIDTH, 0.5);
        [view.layer addSublayer:layer];
        
        [self.effectView.contentView addSubview:view];
    }
    
}

#pragma mark target action

- (void)leftBtnClicked {
    //考试
    ExamViewController *evc = [[ExamViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
}

- (void)rightBtnClicked {
    //查询课程
    TimeTableDiscoverViewController *vc = [TimeTableDiscoverViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)centerBtnClicked {
    //toggle

}

@end
