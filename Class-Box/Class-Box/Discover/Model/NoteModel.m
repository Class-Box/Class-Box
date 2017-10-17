//
//  NoteModel.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.noteId = [aDecoder decodeObjectForKey:@"noteId"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.imgs = [aDecoder decodeObjectForKey:@"imgs"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.classId = [aDecoder decodeObjectForKey:@"classId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_noteId forKey:@"noteId"];
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_imgs forKey:@"imgs"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_classId forKey:@"classId"];
    [aCoder encodeObject:_courseId forKey:@"courseId"];
}
@end
