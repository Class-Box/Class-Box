//
//  LYNetworkTool.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkTool : NSObject<NSCopying>

+ (_Nonnull instancetype)sharedNetworkTool;

- (void)loadDataInfo:(nullable NSString *)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoPost:(nullable NSString *)URLString
              parameters:(nullable id)parameters
                 success:(nullable void (^)(id _Nullable responseObject))success
                 failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoDelete:(nullable NSString *)URLString
                parameters:(nullable id)parameters
                   success:(nullable void (^)(id _Nullable responseObject))success
                   failure:(nullable void (^)(NSError *_Nullable error))failure;


//发送GET请求, 附带json数据
- (void)jsonGET:(NSString *)urlString
      parameters:(id)parameters
         success:(nullable void (^)(id _Nullable responseObject))success
         failure:(nullable void (^)(NSError *_Nullable error))failure;

//发送POST请求, 附带json数据
- (void)jsonPOST:(NSString *)urlString
      parameters:(id)parameters
        success:(nullable void (^)(id _Nullable responseObject))success
        failure:(nullable void (^)(NSError *_Nullable error))failure;

//发送DELETE请求, 附带json数据
-(void)jsonDELETE:(NSString *)urlString
        parameters:(id)parameters
        success:(nullable void (^)(id _Nullable responseObject))success
        failure:(nullable void (^)(NSError *_Nullable error))failure;

@end
