//
//  RegistViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/19.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "RegistViewController.h"
#import "UserDefaults.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_account;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_password_check;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)regist:(id)sender {
    NSString *account = self.tf_account.text;
    NSString *password = self.tf_password.text;
    NSString *password_check = self.tf_password_check.text;
    NSString *name = self.tf_name.text;
    if ([CommonUtils isNull:account]) {
        [Toast showInfo:@"请输入账号"];
        return;
    } else if ([CommonUtils isNull:password]) {
        [Toast showInfo:@"请输入密码"];
        return;
    } else if ([CommonUtils isNull:password_check]){
        [Toast showInfo:@"请输入确认密码"];
        return;
    } else if ([CommonUtils isNull:name]) {
        [Toast showInfo:@"请输入用户名"];
        return;
    }
    
    if (![password_check isEqualToString:password]) {
        [Toast showInfo:@"两次输入密码不一致"];
        return;
    }

    
    
    [[NetworkTool sharedNetworkTool] loadDataInfoPost:REGISTURL parameters:@{@"username" : account , @"password" : password , @"name" : name} success:^(id  _Nullable responseObject) {
        
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        User *user = [[User alloc] init];
        user.username = account;
        user.password = password;
        user.name = name;
        user.id = responseObject[user];
        [UserDefaults setUser:user];
        
    } failure:^(NSError * _Nullable error) {
        [Toast showInfo:@"注册出错"];
    }];
    
}

@end
