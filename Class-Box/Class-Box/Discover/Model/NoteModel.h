//
//  NoteModel.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//



@interface NoteModel : NSObject<NSCoding>

//笔记ID
@property (nonatomic, strong)NSNumber *noteId;
//笔记内容
@property (nonatomic, copy)NSString *content;
//笔记图片
@property (nonatomic, copy)NSArray <NSString *> *imgs;
//发布者ID
@property (nonatomic, strong)NSNumber *userId;
//班级ID
@property (nonatomic, strong)NSNumber *classId;
//课程ID
@property (nonatomic, strong)NSNumber *courseId;
@end
