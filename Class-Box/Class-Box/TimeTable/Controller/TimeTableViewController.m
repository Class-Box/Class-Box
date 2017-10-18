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
#import "Timetable.h"
#import "SemesterView.h"

#import "CommonUtils.h"
#import "NetworkTool.h"
#import "Toast.h"

#define LOADTIMETABLEURL  [CRAWLER_URL stringByAppendingString:@"/zf/timetable"]

@interface TimeTableViewController ()

@property(nonatomic) UIScrollView *scrollView;
@property(nonatomic) UIVisualEffectView *effectView;
@property(nonatomic) TimeTableDetailsView *detailsView;
@property(nonatomic) SemesterView *semesterView;

@property(nonatomic) Boolean isFirst;

@property(nonatomic) NSArray *timetableData;

@end

@implementation TimeTableViewController

#pragma mark system

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"考试" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClicked)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询课程" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClicked)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(centerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"本学期" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;

    [self initViews];
    self.isFirst = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_isFirst) {
        _isFirst = NO;
        SchoolLoginViewController *svc = [SchoolLoginViewController new];
        svc.vc = self;
        [self presentViewController:svc animated:YES completion:nil];
    }
}

#pragma mark mark initView

- (void)initViews {
    self.semesterView = [[SemesterView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, 64)];
    __weak typeof(self) weakself = self;
    self.semesterView.btnClicked = ^(NSString *year, NSString *term) {
        [weakself loadData:year term:term];
    };
    
    [self.view addSubview:self.semesterView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, S_WIDTH, S_HEIGHT - 64 -49)];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
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

- (void)centerBtnClicked:(UIButton *)sender {
    //toggle
    if (!sender.selected) {
        [self downAnimation];
        sender.selected = YES;
    } else {
        [self upAnimation];
        sender.selected = NO;
    }
    
}

- (void)downAnimation {
    [UIView animateWithDuration:0.5f animations:^{
        self.semesterView.frame = CGRectMake(0, 64, S_WIDTH, 64);
        CGRect frame = self.scrollView.frame;
        frame.size.height = frame.size.height - 64;
        frame.origin.y = frame.origin.y + 64;
        self.scrollView.frame = frame;
    } completion:nil];
}

- (void)upAnimation {
    [UIView animateWithDuration:0.5f animations:^{
        self.semesterView.frame = CGRectMake(0, 0, S_WIDTH, 64);
        CGRect frame = self.scrollView.frame;
        frame.size.height = frame.size.height + 64;
        frame.origin.y = frame.origin.y - 64;
        self.scrollView.frame = frame;
    } completion:nil];
}

#pragma custom function 

- (void)loadData:(NSString *)year term:(NSString *)term {
    NSString *url;
    if (year && term) {
        url = [CRAWLER_URL stringByAppendingFormat:@"/zf/timetable?xnd=%@&xqd=%@",year,term];
    } else {
        url = LOADTIMETABLEURL;
    }
    [[NetworkTool sharedNetworkTool] loadDataInfo:url parameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        
        NSArray *timetableRow = dict.allValues.lastObject;
        NSMutableArray *temp = [NSMutableArray new];
        for (NSInteger j = 1; j < timetableRow.count; j++) {//j为第几节课
            NSArray *timetableQueue = timetableRow[j];
            
            for (NSInteger i = 0; i < timetableQueue.count; i++) {//i + 1 为星期几
                NSDictionary *data = timetableQueue[i];
                NSString *text = data[@"text"];
                NSString *rowspan = data[@"rowspan"];
                if (![CommonUtils isNull:text]) {
                    Timetable *timetable = [Timetable new];
                    timetable.rowspan = rowspan ? rowspan.integerValue : 1;
                    timetable.content = text;
                    timetable.place = CGPointMake(j, i);
                    [temp addObject:timetable];
                }
            }
            
        }
        self.timetableData = temp.copy;
        [self.detailsView reloadData:self.timetableData];
        
    } failure:^(NSError * _Nullable error) {
//        [Toast showInfo:@"加载课表失败"];
    }];
}

@end
