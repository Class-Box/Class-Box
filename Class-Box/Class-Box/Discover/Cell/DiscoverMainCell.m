//
//  DiscoverMainCell.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/6.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "DiscoverMainCell.h"
#import "View+MASAdditions.h"
#import "NSArray+MASAdditions.h"
#import "DiscoverMainCellModel.h"


#define IMAGE_WIDTH_HEIGHT 105
#define IMAGE_PADDING 10
@interface DiscoverMainCell()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong)DiscoverMainCellModel *model;

@end

@implementation DiscoverMainCell{
    UIImageView *_userPortraitImageView;
    UILabel *_userNameLabel;
    UILabel *_contentLabel;
    UICollectionView *_imagesView;
    UIView *_lineView;
    UIButton *_commentBtn;
    UIButton *_likeBtn;
    UIButton *_forwardBtn;
    UILabel *_dateLabel;
    UILabel *_courseLabel;
    int num;

    UITapGestureRecognizer *_tap1;
    UITapGestureRecognizer *_tap2;
    UITapGestureRecognizer *_tap3;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}


#pragma mark - 设置数据
- (void)setModel:(DiscoverMainCellModel *)model {
    _model = model;
    _userNameLabel.text = _model.userName;
    _userPortraitImageView.image = _model.portrait;
    _contentLabel.text = _model.content;
    _courseLabel.text = _model.courseName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _dateLabel.text = [formatter stringFromDate:_model.publishDate];
    if (_model.imageArray.count == 0) {
        num = 0;
    } else {
        num = _model.imageArray.count / 3;
        [_imagesView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(num * (IMAGE_PADDING + IMAGE_WIDTH_HEIGHT) - IMAGE_PADDING);
        }];
    }
}

- (void)cancelGestureRecognizer {
    [_userPortraitImageView removeGestureRecognizer:_tap1];
    [_userNameLabel removeGestureRecognizer:_tap2];
    [_dateLabel removeGestureRecognizer:_tap3];
}

#pragma mark - 初始化
- (void)setUpView {
    self.backgroundColor = [UIColor whiteColor];


    //用户头像
    _userPortraitImageView = [[UIImageView alloc] init];
    _userPortraitImageView.layer.masksToBounds = YES;
    _userPortraitImageView.layer.cornerRadius = 20;
    _userPortraitImageView.image = [UIImage imageNamed:@"People"];
    _userPortraitImageView.userInteractionEnabled = YES;
    _tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToUser)];
    [_userPortraitImageView addGestureRecognizer:_tap1];
    [self addSubview:_userPortraitImageView];

    [_userPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(15);
    }];

    //用户名
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.textColor = RGB_COLOR(63, 135, 252);
    _userNameLabel.font = [UIFont systemFontOfSize:18];
    _userNameLabel.userInteractionEnabled = YES;
    _tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToUser)];
    [_userNameLabel addGestureRecognizer:_tap2];
    [self addSubview:_userNameLabel];

    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_userPortraitImageView.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];

    //发布时间
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.userInteractionEnabled = YES;
    _tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToUser)];
    [_dateLabel addGestureRecognizer:_tap3];
    [self addSubview:_dateLabel];

    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(5);
        make.leading.mas_equalTo(_userPortraitImageView.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
    }];


    //课程名称
    _courseLabel = [[UILabel alloc] init];
    _courseLabel.text = @"课程名称";
    _courseLabel.font = [UIFont systemFontOfSize:14];
    _courseLabel.textColor = [UIColor blackColor];
    [self addSubview:_courseLabel];

    [_courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_userPortraitImageView.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
    }];


    //文字内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor blackColor];
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _dateLabel.text = [formatter stringFromDate:date];
    [self addSubview:_contentLabel];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPortraitImageView.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
    }];

    //照片内容
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(IMAGE_WIDTH_HEIGHT, IMAGE_WIDTH_HEIGHT);
    layout.minimumInteritemSpacing = IMAGE_PADDING;
    layout.minimumLineSpacing = IMAGE_PADDING;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _imagesView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _imagesView.delegate = self;
    _imagesView.dataSource = self;
    _imagesView.backgroundColor = [UIColor whiteColor];
    _imagesView.scrollEnabled = NO;
    [_imagesView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_imagesView];

    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.mas_leading).offset(15);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-15);
        make.height.mas_equalTo(0);
    }];

    //分割线
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = RGB_COLOR(231, 231, 237);
    [self addSubview:_lineView];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imagesView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(S_WIDTH, 1));
    }];

    //按钮
    NSMutableArray *array = [NSMutableArray array];

    _forwardBtn = [[UIButton alloc] init];
    [_forwardBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_forwardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forwardBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [_forwardBtn addTarget:self action:@selector(forwardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _forwardBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _forwardBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:_forwardBtn];
    [array addObject:_forwardBtn];

    _commentBtn = [[UIButton alloc] init];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_commentBtn addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentBtn];
    [array addObject:_commentBtn];

    _likeBtn = [[UIButton alloc] init];
    [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _likeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:_likeBtn];
    [array addObject:_likeBtn];

    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];

    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
}


- (void)commentButtonClick {
    if (_delegate) {
        [_delegate commentButtonClick];
    }
}

- (void)forwardButtonClick {
    if (_forwardBtn.selected) {
        [_forwardBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        [_forwardBtn setSelected:NO];
    } else {
        [_forwardBtn setImage:[UIImage imageNamed:@"collection_select"] forState:UIControlStateNormal];
        [_forwardBtn setSelected:YES];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showSuccessWithStatus:@"收藏成功!"];
    }
}

- (void)likeButtonClick {
    if (_likeBtn.selected) {
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeBtn setSelected:NO];
    } else {
        [_likeBtn setImage:[UIImage imageNamed:@"like_select"] forState:UIControlStateNormal];
        [_likeBtn setSelected:YES];
    }
}

- (void)moveToUser {
    if (_delegate) {
        [_delegate userMsgClick];
    }
}

#pragma mark - UICollectionView Delegate DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end
