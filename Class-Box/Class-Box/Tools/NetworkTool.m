//
//  LYNetworkTool.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface NetworkTool ()

@end

@implementation NetworkTool

+ (void)initialize {
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}

#pragma mark - 单例

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedNetworkTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - 工具类方法

/**
 *  加载数据
 */
- (void)loadDataInfo:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id _Nullable responseObject))success
             failure:(void (^)(NSError *error))failure {
    
    [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        //[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        //[SVProgressHUD showSuccessWithStatus:@"获取数据成功"];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
        //[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        //[SVProgressHUD showSuccessWithStatus:@"获取数据失败"];
        failure(error);
    }];
    
}

- (void)loadDataInfoPost:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id _Nullable responseObject))success
             failure:(void (^)(NSError *error))failure {
    [[AFHTTPSessionManager manager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
        failure(error);
    }];
    
}


- (void)loadDataInfoDelete:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id _Nullable responseObject))success
                 failure:(void (^)(NSError *error))failure {
    [[AFHTTPSessionManager manager] DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
        failure(error);
    }];
    
}


@end
