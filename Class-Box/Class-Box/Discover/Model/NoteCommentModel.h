//
//  NoteCommentModel.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/18.
//  Copyright © 2017 sherlock. All rights reserved.
//



@interface NoteCommentModel : NSObject

@property (nonatomic)NSNumber *id;
@property (nonatomic, copy)NSString *content;
@property (nonatomic)NSDate *createdAt;
@property (nonatomic, copy)NSString *commenter;

@end
