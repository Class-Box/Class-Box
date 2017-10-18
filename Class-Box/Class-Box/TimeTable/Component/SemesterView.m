//
//  SemesterView.m
//  Class-Box
//
//  Created by sherlock on 2017/10/3.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "SemesterView.h"
#import "Masonry.h"

@interface SemesterView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITextField *semesterYear;
@property (nonatomic) UILabel *year;
@property (nonatomic) UITextField *semesterTerm;
@property (nonatomic) UILabel *term;
@property (nonatomic) UIButton *decideBtn;

@property (nonatomic) UITableView *selectView;
@property (nonatomic) NSArray *selectData;

@end

@implementation SemesterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!CGRectIsEmpty(frame)) {
        frame.size.height = 70;
    }
    if (self = [super initWithFrame:frame]) {
        self.semesterYear = [[UITextField alloc] init];
        self.semesterYear.delegate = self;
        self.year = [[UILabel alloc] init];
        self.year.text = @"学年";
        self.semesterTerm = [[UITextField alloc] init];
        self.semesterTerm.delegate = self;
        self.term = [[UILabel alloc] init];
        self.term.text = @"学期";
        self.decideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.decideBtn setTitle:@"查询" forState:UIControlStateNormal];
        [self.decideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.decideBtn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.semesterYear];
        [self addSubview:self.year];
        [self addSubview:self.semesterTerm];
        [self addSubview:self.term];
        [self addSubview:self.decideBtn];
        
        self.semesterYear.borderStyle = UITextBorderStyleRoundedRect;
        self.semesterTerm.borderStyle = UITextBorderStyleRoundedRect;
        [self.semesterYear mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(self).offset(10);
            make.size.sizeOffset(CGSizeMake(150, 35));
        }];
        [self.year mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.semesterYear.mas_trailing).offset(8);
            make.centerY.mas_equalTo(self);
        }];
        [self.semesterTerm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(self.year.mas_trailing).offset(8);
            make.size.sizeOffset(CGSizeMake(50, 35));
        }];
        [self.term mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(self.semesterTerm.mas_trailing).offset(8);
        }];
        [self.decideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(-8);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

- (UITableView *)selectView {
    if (_selectView == nil) {
        _selectView = [[UITableView alloc] initWithFrame:CGRectZero];
        _selectView.tableFooterView = UIView.new;
        _selectView.separatorInset = UIEdgeInsetsZero;
        _selectView.rowHeight = 25;
        _selectView.tag = 1;
        _selectView.delegate = self;
        _selectView.dataSource = self;
        _selectView.layer.cornerRadius = 3;
        
        NSDate *now = [NSDate new];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSInteger i = 4; i > 0; i--) {
            [temp addObject:[NSString stringWithFormat:@"%ld-%ld",year, year + 1]];
            year -- ;
        }
        self.selectData = @[temp.copy,@[@1,@2,@3]];
    }
    return _selectView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    CGRect frame = textField.frame;
    if (textField != self.semesterYear) {
        self.selectView.tag = 2;
    } else {
        self.selectView.tag = 1;
    }
    frame = [self convertRect:frame toView:UIApplication.sharedApplication.keyWindow];
    self.selectView.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
    [UIApplication.sharedApplication.keyWindow addSubview:self.selectView];
    [self.selectView reloadData];
    [self.selectView layoutIfNeeded];
    
    NSInteger i = textField == self.semesterYear ? 4 : 3;
    [self showSelectView:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 25*i)];
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.tag == 1 ? 4 : 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideSelectView];
    UITableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    NSString *text= cell.textLabel.text;
    UITextField *tf = self.selectView.tag == 1 ? self.semesterYear : self.semesterTerm;
    tf.text = text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor lightGrayColor];
    if (tableView.tag == 1) {
        cell.textLabel.text = self.selectData.firstObject[indexPath.row];
    } else {
        cell.textLabel.text = ((NSNumber *)self.selectData.lastObject[indexPath.row]).stringValue;
    }
    return cell;
}

- (void)hideSelectView {
    CGRect frame = self.selectView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        self.selectView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    } completion:^(BOOL finished) {
        self.selectView.hidden = YES;
    }];
}

- (void)showSelectView:(CGRect) frame{
    self.selectView.hidden = NO;
    [UIView animateWithDuration:0.5f animations:^{
        self.selectView.frame = frame;
    }];
}

- (void)removeSelectView {
    [self.selectView removeFromSuperview];
}

- (void)buttonClicked {
    !self.btnClicked ?  :self.btnClicked(self.semesterYear.text,self.semesterTerm.text);
}

@end
