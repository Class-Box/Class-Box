//
//  DiscoverMainCellModel.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/6.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DiscoverMainCellModel : NSObject

//内容中包含的照片
@property (nonatomic, copy)NSArray <UIImage *>*imageArray;
//发布者用户名
@property (nonatomic, copy)NSString *userName;
//发布的内容
@property (nonatomic, copy)NSString *content;
//发布者的头像
@property (nonatomic, copy)UIImage *portrait;
//转发数
@property (nonatomic, strong)NSNumber *forwardNum;
//评论数
@property (nonatomic, strong)NSNumber *commentNum;
//是否点赞
@property (nonatomic, assign)bool isLike;
//发布时间
@property (nonatomic, strong)NSDate *publishDate;
@end
