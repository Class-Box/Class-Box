//
//  NoteModel.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//



@interface NoteModel : NSObject<NSCoding>

//笔记ID
@property (nonatomic, strong)NSNumber *id;
//笔记内容
@property (nonatomic, copy)NSString *content;
//笔记图片
@property (nonatomic, copy)NSString *imgs;
//发布者ID
@property (nonatomic, strong)NSNumber *authorId;
//发布人昵称
@property (nonatomic, copy)NSString *author;
//点赞ID
@property (nonatomic, strong)NSNumber *likeId;
//班级名称
@property (nonatomic, copy)NSString *courseName;
//创建时间
@property (nonatomic, copy)NSDate *createdAt;
//收藏ID
@property (nonatomic)NSNumber *iscollected;
@end
