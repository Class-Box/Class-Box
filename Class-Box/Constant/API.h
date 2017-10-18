//
//  API.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/16.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#ifndef API_h
#define API_h

#endif /* API_h */

#define SEVER_IP @"http://127.0.0.1:7001"

//修改用户昵称
#define PATCH_USER_NAME_API [SEVER_IP stringByAppendingString:@"/api/users"]
//修改用户个性签名
#define PATCH_USER_SIGN_APT [SEVER_IP stringByAppendingString:@"/api/users"]
//发布笔记
#define POST_NOTE [SEVER_IP stringByAppendingString:@""]
//获取关注的笔记
#define FOLLOWING_NOTE_API [SEVER_IP stringByAppendingString:@"/api/follower"]
//评论某条笔记
#define COMMENT_NOTE_APT [SEVER_IP stringByAppendingString:@"/api/follower"]
//点赞某条笔记
#define LIKE_NOTE_API [SEVER_IP stringByAppendingString:@"/api/users"]
//取消点赞某条笔记
#define UNLIKE_NOTE_API [SEVER_IP stringByAppendingString:@"/api/users"]
//收藏某条笔记
#define COLLECTION_NOTE_API [SEVER_IP stringByAppendingString:@""]
//取消收藏某条笔记
#define UNCOLLECTOR_NOTE_API [SEVER_IP stringByAppendingString:@""]
//删除本人已经发送的某条笔记
#define DELETE_NOTE_API [SEVER_IP stringByAppendingString:@""]
//获取同班同学的列表
#define LIST_CLASSMATE_API [SEVER_IP stringByAppendingString:@""]
//获取同班同学所发的笔记列表
#define LIST_CLASSMATE_NOTE_APT [SEVER_IP stringByAppendingString:@""]
//搜索关于某个课程的笔记
#define LIST_COURSE_NOTE_API [SEVER_IP stringByAppendingString:@""]
//综合搜索(关键词搜索，包含以下几种搜索)
#define SEARCH_ALL_API [SEVER_IP stringByAppendingString:@""]
//搜索笔记内容
#define SEARCH_NOTE_API [SEVER_IP stringByAppendingString:@""]
//搜索课程
#define SEARCH_COURSE_API [SEVER_IP stringByAppendingString:@""]
//搜索用户
#define SEARCH_USER_API [SEVER_IP stringByAppendingString:@""]
//我收藏的笔记
#define LIST_COLLECT_NOTE_API [SEVER_IP stringByAppendingString:@""]
//我关注的人
#define LIST_FOLLOWING_API [SEVER_IP stringByAppendingString:@""]
//我的粉丝
#define LIST_FOLLOWER_API [SEVER_IP stringByAppendingString:@""]"


