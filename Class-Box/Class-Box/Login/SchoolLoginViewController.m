//
//  SchoolLoginViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/13.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "SchoolLoginViewController.h"
#import "UserDefaults.h"
#import "UIImageView+WebCache.h"
#import "NetworkTool.h"
#import "TimeTableViewController.h"

#define CAMPUSAUTHENTICATIONURL [CRAWLER_URL stringByAppendingString:@"/zf/off_campus_authentication"]
#define CHECKCODEURL [CRAWLER_URL stringByAppendingString:@"/zf/check_code"]
#define LOGINURL [CRAWLER_URL stringByAppendingString:@"/zf/login"]
#define PERSONINFOURL [CRAWLER_URL stringByAppendingString:@"/zf/personal"]

#define PERSONINFOBINDURL [ASERVER_URL stringByAppendingString:@"/api/bind"]

@interface SchoolLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_account;
@property (weak, nonatomic) IBOutlet UITextField *tf_identity;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_qcode;
@property (weak, nonatomic) IBOutlet UIImageView *img_qcode;

@end

@implementation SchoolLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.img_qcode.userInteractionEnabled = YES;
    [self.img_qcode addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCheckCode)]];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getPersonInfoAndBind {
    [[NetworkTool sharedNetworkTool] loadDataInfo:PERSONINFOURL parameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"personal"];
        NSString *instituteName = dict[@"lbl_xy"];
        NSString *majorName = dict[@"lbl_zymc"];
        NSString *className = dict[@"lbl_xzb"];
        NSString *userId = dict[@"xm"];
        
        [[NetworkTool sharedNetworkTool] loadDataInfoPost:PERSONINFOBINDURL parameters:@{@"instituteName" : instituteName , @"majorName" : majorName , @"className" : className , userId : @"userId" , @"schoolName" : @"浙江科技学院"} success:^(id  _Nullable responseObject) {
            
            NSDictionary *dict = responseObject[@"result"];
            User *user = [UserDefaults getUser];
            user.instituteId = dict[@"instituteId"];
            user.majorId = dict[@"majorId"];
            user.classId = dict[@"classId"];
            user.schoolId = dict[@"schoolId"];
            [UserDefaults setUser:user];
            
        } failure:^(NSError * _Nullable error) {
            
        }];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (IBAction)btn_import:(UIButton *)sender {
    NSString *userName = self.tf_account.text;
    NSString *password = self.tf_password.text;
    NSString *code = self.tf_qcode.text;
    if ([CommonUtils isNull:userName]) {
        [Toast showInfo:@"账号不能为空"];
        return;
    } else if ([CommonUtils isNull:password]) {
        [Toast showInfo:@"密码不能为空"];
        return;
    } else if ([CommonUtils isNull:code]) {
        [Toast showInfo:@"验证码不能为空"];
        return;
    }
    
    [[NetworkTool sharedNetworkTool] loadDataInfoPost:LOGINURL parameters:@{
        @"username": userName,@"password": password,@"check_code": code
    } success:^(id  _Nullable responseObject) {
        
        [Toast showInfo:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:^{
            [((TimeTableViewController *)self.vc) loadData:nil term:nil];
            [self getPersonInfoAndBind];
        }];
        
    } failure:^(NSError * _Nullable error) {
        [Toast showInfo:@"登录失败,请检查网络是否正常"];
    }];
    
}


- (IBAction)btn_getCode:(id)sender {
    NSString *account = self.tf_account.text;
    NSString *identity = self.tf_identity.text;
    if ([CommonUtils isNull:account]) {
        [Toast showInfo:@"账号不能为空"];
        return;
    } else if ([CommonUtils isNull:identity]) {
        [Toast showInfo:@"校外访问密码不能为空"];
        return;
    }
    [[NetworkTool sharedNetworkTool] loadDataInfoPost:CAMPUSAUTHENTICATIONURL parameters:@{@"username" : account , @"password" : identity} success:^(id  _Nullable responseObject) {
        [self getCheckCode];
    } failure:^(NSError * _Nullable error) {
        NSLog(@"%@",error.localizedFailureReason);
    }];
}

- (void)getCheckCode {
    [[NetworkTool sharedNetworkTool] loadDataInfo:CHECKCODEURL
                                       parameters:nil success:^(id  _Nullable responseObject) {
                                           NSDictionary *dict = responseObject;
                                           NSString *url =[CRAWLER_URL stringByAppendingString:dict[@"check_code_url"]];
                                           [self.img_qcode sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
                                       } failure:^(NSError * _Nullable error) {
                                           NSLog(@"%@",error.localizedFailureReason);
                                       }];
}

@end
