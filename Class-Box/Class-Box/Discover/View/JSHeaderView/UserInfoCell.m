//
//  UserInfoCell.m
//  JSHeaderView
//
//  Created by 雷亮 on 16/8/1.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UserInfoCell.h"
#import "View+MASAdditions.h"
#import "UserDefaults.h"
#import "NetworkTool.h"

@interface UserInfoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *editInfoButton;

@end

@implementation UserInfoCell {
    User *_userModel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.infoLabel];
        [self addSubview:self.editInfoButton];
        [self setConstraints];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"张力明";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"一个逗比程序员，做一个段子界最好的iOS开发者\n\n写了3638字，获得62个喜欢";
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor darkTextColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = [UIFont systemFontOfSize:11];
    }
    return _infoLabel;
}

- (UIButton *)editInfoButton {
    if (!_editInfoButton) {
        _editInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editInfoButton setTitle:@"关注" forState:UIControlStateNormal];
        _editInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_editInfoButton setTitleColor:HEXCOLOR(0x88e47a) forState:UIControlStateNormal];
        _editInfoButton.layer.borderColor = HEXCOLOR(0x88e47a).CGColor;
        _editInfoButton.layer.cornerRadius = 4;
        _editInfoButton.layer.borderWidth = 0.5f;
        [_editInfoButton setSelected:NO];
        [_editInfoButton addTarget:self action:@selector(handleEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editInfoButton;
}

- (void)handleEditAction:(UIButton *)sender {
    if(!sender.selected) {

        [[NetworkTool sharedNetworkTool] jsonPOST:UNFOLLOW_API parameters:@{
                @"from_id" : [UserDefaults getUserId],
                @"to_id" : _userModel.id
        } success:^(id responseObject) {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showSuccessWithStatus:@"关注成功!"];
            [_editInfoButton setSelected:YES];
            [_editInfoButton setTitle:@"已关注" forState:UIControlStateNormal];
            [_editInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _editInfoButton.backgroundColor = HEXCOLOR(0x88e47a);
        } failure:^(NSError *error) {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }];
    } else {
        [[NetworkTool sharedNetworkTool] jsonDELETE:[UNFOLLOW_API stringByAppendingFormat:@"/%@", _userModel.followId] parameters:nil
                                            success:^(id responseObject) {
                                                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                                                [SVProgressHUD showSuccessWithStatus:@"取关成功"];
                                                [_editInfoButton setSelected:NO];
                                                [_editInfoButton setTitle:@"关注" forState:UIControlStateNormal];
                                                [_editInfoButton setTitleColor:HEXCOLOR(0x88e47a) forState:UIControlStateNormal];
                                                _editInfoButton.backgroundColor = [UIColor whiteColor];
                                            } failure:^(NSError *error) {
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                    [SVProgressHUD showErrorWithStatus:@"失败"];
                }];
    }
}

- (void)setConstraints {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(50);
    }];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
    }];
    [_editInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}


- (void)setUserModel:(User *)userModel {
    _userModel = userModel;
    _nameLabel.text = userModel.username;
    _infoLabel.text = userModel.des;
    if ([userModel.id isEqualToNumber:[UserDefaults getUserId]]) {
        _editInfoButton.hidden = YES;
    } else if (userModel.followId) {
        [_editInfoButton setSelected:YES];
        [_editInfoButton setTitle:@"已关注" forState:UIControlStateNormal];
        [_editInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _editInfoButton.backgroundColor = HEXCOLOR(0x88e47a);
    }
}

@end
