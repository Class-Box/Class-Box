//
//  DiscoverCommentCell.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

@protocol DiscoverCommentCellDelegate<NSObject>

- (void)moveToUser;

@end

@interface DiscoverCommentCell : UITableViewCell

@property (nonatomic, weak)id<DiscoverCommentCellDelegate> delegate;

- (void)setMsgWithUserName:(NSString *)userName image:(UIImage *)userPortrait content:(NSString *)content;

@end
