//
//  SchoolLoginViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/13.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "SchoolLoginViewController.h"
#import "MBProgressHUD.h"

@interface SchoolLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_account;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_identity;
@property (weak, nonatomic) IBOutlet UITextField *tf_qcode;
@property (weak, nonatomic) IBOutlet UIImageView *img_qcode;

@end

@implementation SchoolLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btn_import:(UIButton *)sender {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
//    hud.label.text = @"正在登录";
}



@end
