//
//  DiscoverCommentCell.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "DiscoverCommentCell.h"
#import <Masonry/Masonry.h>

@implementation DiscoverCommentCell {
    UIImageView *_userPortraitImageView;
    UILabel *_userNameLabel;
    UILabel *_contentLabel;
    UILabel *_dateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToUser)];

    _userPortraitImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"People"]];
    _userPortraitImageView.layer.masksToBounds = YES;
    _userPortraitImageView.layer.cornerRadius = 20;
    _userPortraitImageView.userInteractionEnabled = YES;
    [_userPortraitImageView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:_userPortraitImageView];
    [_userPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(15);
    }];

    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"未知用户";
    _userNameLabel.textColor = RGB_COLOR(63, 135, 252);
    _userNameLabel.font = [UIFont systemFontOfSize:18];
    _userNameLabel.userInteractionEnabled = YES;
    [_userNameLabel addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:_userNameLabel];

    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_userPortraitImageView.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];

    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textColor = [UIColor lightGrayColor];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    _dateLabel.text = dateString;
    [self addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(10);
        make.leading.mas_equalTo(_userPortraitImageView.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
    }];


    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = RGB_COLOR(123, 123, 123);
    _contentLabel.text = @"这里是正文";
    [self addSubview:_contentLabel];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateLabel.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
}

- (void)setMsgWithUserName:(NSString *)userName image:(UIImage *)userPortrait content:(NSString *)content creatDate:(NSDate *)creatDate{
    if (![userName isEqualToString:@""]) {
        _userNameLabel.text = userName;
    }
    if (userPortrait) {
        _userPortraitImageView.image = userPortrait;
    }
    if (![content isEqualToString:@""]) {
        _contentLabel.text = content;
    }

    if (creatDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *dateString = [formatter stringFromDate:creatDate];
        _dateLabel.text = dateString;
    }

}

- (void)moveToUser {
    if (_delegate) {
        [_delegate moveToUser];
    }
}
@end
