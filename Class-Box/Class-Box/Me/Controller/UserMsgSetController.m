//
//  UserMsgSetController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "UserMsgSetController.h"
#import "HXPhotoViewController.h"
#import "MainPatchMsgController.h"

#define USER_NAME @"user_name"
#define SIGNATURE @"Signature of personality\n"


@interface UserMsgSetController()<HXPhotoViewControllerDelegate, MainPatchMsgControllerDelegate>
@property (strong, nonatomic) HXPhotoManager *manager;

@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *signature;
@property (strong, nonatomic) UIImage *portraitImage;
@end

@implementation UserMsgSetController {

}

#pragma mark - 懒加载
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.lookGifPhoto = NO;
        _manager.lookLivePhoto = NO;
        _manager.photoMaxNum = 1;
    }
    return _manager;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"个人信息"];
    self.userName = @"张力明";
    self.signature = @"大家好，我是张力明";
    self.portraitImage = [UIImage imageNamed:@"People"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
}


- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *portraitCell = [tableView dequeueReusableCellWithIdentifier:@"portraitCell"];
        if (!portraitCell) {
            portraitCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"portraitCell"];
        }
        UILabel *portraitLabel = [[UILabel alloc] init];
        portraitLabel.text = @"头像";
        [portraitCell addSubview:portraitLabel];
        [portraitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(portraitCell.mas_leading).offset(10);
            make.centerY.mas_equalTo(portraitCell.mas_centerY);
        }];
        UIImageView *portraitImageView = [[UIImageView alloc] initWithImage:self.portraitImage];
        [portraitCell addSubview:portraitImageView];
        [portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.trailing.mas_equalTo(portraitCell.mas_trailing).offset(-20);
            make.centerY.mas_equalTo(portraitCell.mas_centerY);
        }];
        return portraitCell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userNameCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userNameCell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"用户名：%@", self.userName];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signCell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"个性签名：%@", self.signature];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0) {
        HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
        vc.delegate = self;
        vc.manager = self.manager;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        MainPatchMsgController *patchMsgController = [[MainPatchMsgController alloc] initWithTitle:@"修改用户名" withDefaultText:self.userName key:USER_NAME];
        patchMsgController.delegate = self;
        [self.navigationController pushViewController:patchMsgController animated:YES];
    } else if (indexPath.row == 2) {
        MainPatchMsgController *patchMsgController = [[MainPatchMsgController alloc] initWithTitle:@"修改个性签名" withDefaultText:self.userName key:SIGNATURE];
        patchMsgController.delegate = self;
        [self.navigationController pushViewController:patchMsgController animated:YES];
    }
}


- (void)photoViewControllerDidNext:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)original {
    HXPhotoModel *photoModel = photos.firstObject;
    self.portraitImage = photoModel.thumbPhoto;
    [self.tableView reloadData];
}

#pragma mark - MainPatchMsgControllerDelegate
- (void)completeButtonClickWithText:(NSString *)text andKey:(NSString *)key {
    if ([key isEqualToString:USER_NAME]) {
        self.userName = text;
    } else if ([key isEqualToString:SIGNATURE]) {
        self.signature = text;
    }
    [self.tableView reloadData];
}

@end

