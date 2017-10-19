//
//  DiscoverSearchViewController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/6.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/NSArray+MASAdditions.h>
#import "DiscoverSearchViewController.h"
#import "View+MASAdditions.h"
#import "DiscoverMainCell.h"
#import "DiscoverMainCellModel.h"
#import "DiscoverCommentController.h"
#import "DiscoverUserCenterController.h"
#import "DiscoverUserMsgCell.h"

typedef NS_ENUM(NSInteger, SearchModel) {
    SearchModelNote,
    SearchModelUser,
};

@interface  DiscoverSearchViewController()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, DiscoverMainCellDelegate, UITextFieldDelegate>

@property (nonatomic, assign)NSInteger searchModel;

@end

@implementation DiscoverSearchViewController {
    UITextField *_searchTextField;
    UIButton *_cancelButton;

    UIView *_selectView;
    UIButton *_noteButton;
    UIButton *_userButton;
    UIView *_lineView;

    UITableView *_tableView;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    self.searchModel = SearchModelNote;
    self.title = @"搜索";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - 初始化
- (void)setUpView {
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.backgroundColor = RGB_COLOR(230, 230, 230);
    _searchTextField.layer.cornerRadius = 10;
    _searchTextField.layer.masksToBounds = YES;
    _searchTextField.delegate = self;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 18)];
    UIImageView *searchIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    searchIconView.frame = CGRectMake(5, 0, 15, 15);
    [leftView addSubview:searchIconView];
    _searchTextField.leftView = leftView;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.leading.mas_equalTo(self.view.mas_leading).offset(10);
        make.size.mas_equalTo(CGSizeMake(S_WIDTH * 0.75, 30));
    }];
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitleColor:RGB_COLOR(27, 114, 254) forState:UIControlStateNormal];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_searchTextField.mas_trailing).offset(10);
        make.centerY.mas_equalTo(_searchTextField.mas_centerY);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-10);
    }];

    [self setSelectView];
    [self setUpTableView];
}

- (void)cancelButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//选择栏
- (void)setSelectView {
    _selectView = [[UIView alloc] init];
    _selectView.layer.borderColor = [RGB_COLOR(230, 230, 230) CGColor];
    _selectView.layer.borderWidth = 0.5;
    [self.view addSubview:_selectView];
    [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchTextField.mas_bottom).offset(10);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];

    //笔记
    _noteButton = [[UIButton alloc] init];
    [_noteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_noteButton setTitleColor:RGB_COLOR(27, 114, 254) forState:UIControlStateSelected];
    _noteButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_noteButton setSelected:NO];
    [_noteButton setTitle:@"笔记" forState:UIControlStateNormal];
    [_noteButton addTarget:self action:@selector(noteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_noteButton];



    //用户
    _userButton = [[UIButton alloc] init];
    [_userButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_userButton setTitleColor:RGB_COLOR(27, 114, 254) forState:UIControlStateSelected];
    _userButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_userButton setTitle:@"用户" forState:UIControlStateNormal];
    [_userButton setSelected:NO];
    [_userButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_userButton];

    NSArray *viewArray = @[_noteButton, _userButton];
    [viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectView.mas_centerY);
        make.height.mas_equalTo(30);
    }];

    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = RGB_COLOR(27, 114, 254);
    [_selectView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_noteButton.mas_leading).offset(5);
        make.trailing.mas_equalTo(_noteButton.mas_trailing).offset(-5);
        make.bottom.mas_equalTo(_selectView.mas_bottom);
        make.height.mas_equalTo(3);
    }];
}


- (void)noteButtonClick {
    [_noteButton setSelected:YES];
    [_userButton setSelected:NO];
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:nil animations:^{
        _lineView.frame = CGRectMake(_noteButton.frame.origin.x+5, _selectView.bounds.size.height-5, _noteButton.frame.size.width - 10, 3);
    } completion:nil];
    self.searchModel = SearchModelNote;
    [_tableView reloadData];
}



- (void)userButtonClick {
    [_noteButton setSelected:NO];
    [_userButton setSelected:YES];
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:nil animations:^{
        _lineView.frame = CGRectMake(_userButton.frame.origin.x+5, _selectView.bounds.size.height-5, _userButton.frame.size.width - 10, 3);
    } completion:nil];
    self.searchModel = SearchModelUser;
    [_tableView reloadData];
}

- (void)setUpTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selectView.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.searchModel) {
        case SearchModelNote: {
            return 6;
        }
        case SearchModelUser: {
            return 6;
        }
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.searchModel) {
        case SearchModelNote: {
            DiscoverMainCell *cell = (DiscoverMainCell *)[tableView dequeueReusableCellWithIdentifier:@"noteCell"];
            if (!cell) {
                cell = [[DiscoverMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noteCell"];
            }
            DiscoverMainCellModel *model = [[DiscoverMainCellModel alloc] init];
            model.portrait = [UIImage imageNamed:@"People"];
            model.userName = @"张力明";
            model.content = @"这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear, 这里是正文Content Hear";
            model.imageArray = @[@"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad", @"dad"];
            model.publishDate = [[NSDate alloc] init];
            [cell setModel:model];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case SearchModelUser: {
            DiscoverUserMsgCell *cell = (DiscoverUserMsgCell *)[tableView dequeueReusableCellWithIdentifier:@"userCell"];
            if (!cell) {
                cell = [[DiscoverUserMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
            }
            return cell;
        }
        default: {
            return nil;
        }

    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edg = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.separatorInset = edg;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchModel == SearchModelUser) {
        [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - DiscoverMainCellDelegate
- (void)commentButtonClick {
    [self.navigationController pushViewController:[[DiscoverCommentController alloc] init] animated:YES];
}

- (void)userMsgClick {
    [self.navigationController pushViewController:[[DiscoverUserCenterController alloc] init] animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    if (![_searchTextField.text isEqualToString:@""]) {

    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
@end
