//
//  MianNoteController.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017 sherlock. All rights reserved.
//



#import "BaseViewController.h"

@class NoteModel;

@interface MainNoteController : BaseViewController

- (instancetype)initWithTitle:(NSString *)title noteModelArray:(NSArray <NoteModel *>*)noteArray;


@end
