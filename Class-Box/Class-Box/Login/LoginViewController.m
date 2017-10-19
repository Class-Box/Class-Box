//
//  LoginViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/13.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserDefaults.h"
#import "MJExtension.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_account;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (IBAction)login:(id)sender {
    
    NSString *account = self.tf_account.text;
    NSString *password = self.tf_password.text;
    if ([CommonUtils isNull:account]) {
        [Toast showInfo:@"请输入账号"];
        return;
    } else if ([CommonUtils isNull:password]) {
        [Toast showInfo:@"请输入密码"];
        return;
    }
    
    [[NetworkTool sharedNetworkTool] loadDataInfoPost:LOGINURL parameters:@{@"username" : account , @"password" : password} success:^(id  _Nullable responseObject) {
        
        self.navigationController.navigationBarHidden = NO;
        User *user = [User mj_objectWithKeyValues:responseObject];
        [UserDefaults setUser:user];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError * _Nullable error) {
        [Toast showInfo:@"登录出错"];
    }];
}

- (IBAction)regist:(id)sender {
    RegistViewController *registVc = [RegistViewController new];
    [self.navigationController pushViewController:registVc animated:YES];
}

@end
