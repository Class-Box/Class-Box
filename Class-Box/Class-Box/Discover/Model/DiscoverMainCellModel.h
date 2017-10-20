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
@property (nonatomic, copy)NSString*img;
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
//点赞ID
@property (nonatomic)NSNumber *likeId;
//收藏ID
@property (nonatomic)NSNumber *collectId;
//发布时间
@property (nonatomic, strong)NSDate *publishDate;
//课程名称
@property (nonatomic, copy)NSString *courseName;
//笔记ID
@property (nonatomic, strong)NSNumber *noteId;
@property (nonatomic, strong)NSNumber *userId;

@end
