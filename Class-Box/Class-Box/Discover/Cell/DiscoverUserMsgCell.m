//
//  DiscoverUserMsgCell.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "DiscoverUserMsgCell.h"
#import "UserInfoCell.h"
#import "UserDefaults.h"
#import "NetworkTool.h"

@implementation DiscoverUserMsgCell {
    UIImageView *_portraitView;
    UILabel *_userNameLabel;
    UILabel *_describeLabel;
    UIButton *_followButton;

    User *_userModel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    _portraitView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"People"]];
    _portraitView.layer.cornerRadius = 20;
    _portraitView.layer.masksToBounds = YES;
    [self addSubview:_portraitView];

    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.textColor = RGB_COLOR(27, 114, 254);
    _userNameLabel.text = @"用户名";
    _userNameLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_portraitView.mas_trailing).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(S_WIDTH * 0.6);
    }];

    _describeLabel = [[UILabel alloc] init];
    _describeLabel.text = @"";
    _describeLabel.textColor = [UIColor lightGrayColor];
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_describeLabel];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_portraitView.mas_trailing).offset(10);
        make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(S_WIDTH * 0.6);
    }];

    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
    [_followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _followButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_followButton setTitleColor:HEXCOLOR(0x88e47a) forState:UIControlStateNormal];
    _followButton.layer.borderColor = HEXCOLOR(0x88e47a).CGColor;
    _followButton.layer.cornerRadius = 4;
    _followButton.layer.borderWidth = 0.5f;
    [_followButton setSelected:NO];
    [_followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_followButton];
    [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];

}

- (void)followButtonClick:(UIButton *)sender {
    if(!sender.selected) {
        _followButton.backgroundColor = HEXCOLOR(0x88e47a);
        [[NetworkTool sharedNetworkTool] jsonPOST:FOLLOW_API parameters:@{
                @"from_id" : [UserDefaults getUserId],
                @"to_id" : _userModel.id
        } success:^(id responseObject) {
            NSNumber *followId = responseObject[@"follow"];
            _userModel.followId = followId;
            [_followButton setSelected:YES];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
        } failure:^(NSError *error) {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }];
    } else {
        [[NetworkTool sharedNetworkTool] jsonDELETE:[UNFOLLOW_API stringByAppendingFormat:@"/%@", _userModel.followId] parameters:nil
                                                                                                                          success:^(id responseObject) {
                                                                                                                              [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                                                                                                                              [SVProgressHUD showSuccessWithStatus:@"取关成功"];
                                                                                                                              [_followButton setSelected:NO];
                                                                                                                              _followButton.backgroundColor = [UIColor whiteColor];
                                                                                                                          } failure:^(NSError *error) {
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                    [SVProgressHUD showErrorWithStatus:@"失败"];
                }];
    }
}

- (void)setUserModel:(User *)userModel {
    if (userModel) {
        _userModel = userModel;
        _userNameLabel.text = userModel.username ? userModel.username : @"";
        _describeLabel.text = userModel.des ? userModel.des : @"";
        if (_userModel.followId) {
            [_followButton setSelected:YES];
            _followButton.backgroundColor = HEXCOLOR(0x88e47a);
        }
    }
}
@end
