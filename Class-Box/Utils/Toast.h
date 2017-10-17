//
//  Toast.h
//
//  Created by Yu on 15/7/31.
//

#import "MBProgressHUD.h"

@interface Toast : NSObject<MBProgressHUDDelegate>

//--------------------------------------------showToast----------------------------------------------//

///显示纯文字(默认时间2秒)
+(void)showInfo:(NSString*)txt;

///显示纯文字(默认时间2秒)
+(void)show:(UIView*)parentView Txt:(NSString*)txt;

///显示纯文字(自定义时间)
+(void)show:(UIView*)parentView Txt:(NSString*)txt Duration:(NSTimeInterval)time;

//--------------------------------------------showLoading----------------------------------------------//

///显示加载等待框(默认文字:正在加载中...)-------->>>>>>----------------------------//
+(void)showLoading:(UIView*)parentView;                                      //
                                                                             //
///显示加载等待框(自定义文字)------------------->>>>>>---------------------------//
+(void)showLoading:(UIView*)parentView Tips:(NSString*)tips;                 //
                                                                             //
///隐藏   <--------------------等待动作完成后记得要调用隐藏方法-------<<<<<<-------//
+(void)dissmiss;
@end
