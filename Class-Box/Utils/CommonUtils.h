//
//  CommonUtils.h
//  App
//
//  Created by Yu on 15/12/1.
//  Copyright © 2015年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

///常用方法类
#import <UIKit/UIKit.h>
@interface CommonUtils : NSObject

///系统版本号
+(float)IOSVersion;

///app版本号
+(NSString*)AppVersion;

///app名称
+(NSString*)AppName;

///内部版本号
+(NSString*)AppBuild;

///打开浏览器
+(void)Open_Url:(NSString*)url;

///打电话
+(void)Phone_call:(NSString*)phone;





///当前时间（秒）
+(NSInteger)currentTime;

///当前时间（天）yyyyMMdd
+(NSString*)currentDay;

///时间转换成对应格式
+(NSString*)getDayWithFormat:(NSString*)format Date:(NSInteger)time;

///毫秒转时间 yyyy-MM-dd
+(NSString*)MillToDate:(NSTimeInterval)mill;



///UIColor---->UIImage
+(UIImage *) ImageWithColor:(UIColor*)color width:(float)w height:(float) y;

///图片质量压缩，压倒100k以下
+(NSData*) qualityCompress:(UIImage*)image;

///图片比例压缩
+(UIImage*) proportionCompress:(UIImage*)image Size:(NSInteger)size;

///在Bundle中获取图片
+(NSString*)getImageFromBundle:(NSString*)bundleName ImgName:(NSString*)imgName Type:(NSString*)type;

///照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image;





///获取字体宽度和高度（用于tablecell动态变化高度）  string:文字   Font:字体  ConstrainedToSize:最大尺寸  LineBreakMode:行分割模式
+(CGSize)sizeForString:(NSString *)string Font:(UIFont *)font ConstrainedToSize:(CGSize)constrainedSize LineBreakMode:(NSLineBreakMode)lineBreakMode;

///计算一个view相对于屏幕的坐标
+ (CGRect)relativeFrameForScreenWithView:(UIView *)v;






///添加下划线
+(void)addUnderline:(UILabel*)view Text:(NSString*)txt Start:(NSInteger)start Length:(NSInteger)length Color:(UIColor*)color;

///正则表达式验证 type 1手机号(11位手机号);2,密码(6-12位字母或数字)
+(BOOL)checkFormat:(NSString*)str Type:(NSInteger)type;

///stringEncode
+(NSString *)stringEncode:(NSString*)input;

///jsonString转NSDictionary
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

///判断string是否为空
+(BOOL)isNull:(NSString*) str;

///判断str是否包含key
+(BOOL)isContainStr:(NSString*)str Key:(NSString*)key;

///获取字符串
+(NSString*)getStr:(NSString*)str;







///判断文件是否存在
+(BOOL)fileIsExit:(NSString*) filePath;

///获取文件绝对路径
+(NSString*)fileAbsolutePath:(NSString*)path;



///3d旋转
+(void)rotation3D:(UIView*)v Angle:(CGFloat)angle;

@end
