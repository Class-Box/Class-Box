//
//  CommonUtils.m
//  App
//
//  Created by Yu on 15/12/1.
//  Copyright © 2015年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+(float)IOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(NSString*)AppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString*)AppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+(NSString*)AppBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+(NSInteger)currentTime
{
    NSInteger time=[[NSDate date] timeIntervalSince1970];
    return time;
}

+(NSString*)currentDay
{
    return [CommonUtils getDayWithFormat:@"yyyyMMdd" Date:[CommonUtils currentTime]];
}

+(NSString*)getDayWithFormat:(NSString*)format Date:(NSInteger)time
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *DateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
    
    return DateStr;
}

+(NSString*)MillToDate:(NSTimeInterval)mill
{
    return [CommonUtils getDayWithFormat:@"yyyy-MM-dd" Date:mill];
}


+(UIImage *) ImageWithColor:(UIColor*)color width:(float)w height:(float) y
{
    CGRect aFrame=CGRectMake(0, 0, w, y);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+(NSData*) qualityCompress:(UIImage*)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    if([data length]>(100*1024))
    {
        CGFloat quality=((CGFloat)(100*1024)/(CGFloat)[data length]);
        quality=[[NSString stringWithFormat:@"%.2f",quality] floatValue];
        if(quality>0.9){
            quality=0.9;
        }
        if(quality<0.15){
            quality=0.15;
        }
        data =UIImageJPEGRepresentation(image,quality);
    }
    //NSLog(@"qualityCompress data length:%lu",(unsigned long)data.length/1024);
    return data;
}

+(UIImage*) proportionCompress:(UIImage*)image Size:(NSInteger)size
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float width = size;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    if(imageWidth>size||imageHeight>size){
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        
        if (widthScale > heightScale) {
            [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
        }
        else {
            [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
        }
        
        // 从当前context中创建一个改变大小后的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        return newImage;
    }else{
        return image;
    }
}

+(CGSize)sizeForString:(NSString *)string Font:(UIFont *)font ConstrainedToSize:(CGSize)constrainedSize LineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //ceilf   如果参数是小数，则求最小的整数但不小于本身
    return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    
}

+ (CGRect)relativeFrameForScreenWithView:(UIView *)v
{
    UIView *view = v;
    CGFloat x = .0;
    CGFloat y = .0;
    while (view.frame.size.width != S_WIDTH || view.frame.size.height != S_HEIGHT) {
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
        if ([view isKindOfClass:[UIScrollView class]]) {
            x -= ((UIScrollView *) view).contentOffset.x;
            y -= ((UIScrollView *) view).contentOffset.y;
        }
    }
    return CGRectMake(x, y, v.frame.size.width, v.frame.size.height);
}

+(NSString *)stringEncode:(NSString*)input
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL,NULL, kCFStringEncodingUTF8));
    return encodedString;
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if ([CommonUtils isNull:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(void)Open_Url:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+(void)Phone_call:(NSString*)phone
{
    NSString *str=[NSString stringWithFormat:@"tel://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+(BOOL)isNull:(NSString*) str
{
    if([str isKindOfClass:[NSNull class]]||str==nil||str==NULL||[str isEqualToString:@"(null)"]){
        return YES;
    }else{
        NSString *str1=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str1 isEqualToString:@""]||str1.length<1) {
            return YES;
        }
        return NO;
    }
}

+(BOOL)isContainStr:(NSString*)str Key:(NSString*)key
{
    NSRange range=[str rangeOfString:key];
    if(range.length>0){
        return YES;
    }
    return  NO;
}

+(NSString*)getStr:(NSString*)str
{
    if ([CommonUtils isNull:str]) {
        return @"";
    }
    return str;
}

+(BOOL)fileIsExit:(NSString*) filePath
{
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return YES;
    }else{
        return  NO;
    }
}

+(NSString*)fileAbsolutePath:(NSString*)path
{
    NSArray *aArray = [path componentsSeparatedByString:@"."];
    NSString *filename = [aArray objectAtIndex:0];
    NSString *sufix = [aArray objectAtIndex:1];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
    return imagePath;
}

+(NSString*)getImageFromBundle:(NSString*)bundleName ImgName:(NSString*)imgName Type:(NSString*)type
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:imgName ofType:type];
    return path;
}

///照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image {
    if (Image==nil) {
        return @"";
    }
    
    NSString *filePath = nil;
    // 压缩图片
    NSData *data = [CommonUtils qualityCompress:Image];

    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    
    return filePath;
}

+(void)addUnderline:(UILabel*)view Text:(NSString*)txt Start:(NSInteger)start Length:(NSInteger)length Color:(UIColor*)color
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:txt];
    NSRange contentRange = {start,length};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    if (color) {
        [content addAttribute:NSForegroundColorAttributeName value:color range:contentRange];
    }
    
    view.attributedText=content;
}

+(BOOL)checkFormat:(NSString*)str Type:(NSInteger)type
{
    if ([CommonUtils isNull:str]) {
        return false;
    }
    
    NSString *rule=@"";
    if (type==1) {
        if (str.length!=11) {
            return false;
        }
        rule=@"^1[3-8]+\\d{9}$";
    }else{
        if (str.length<6||str.length>12) {
            return false;
        }
        rule=@"^[A-Za-z0-9\u4e00-\u9fa5]+$";
    }
    
    NSRegularExpression *regex= [NSRegularExpression regularExpressionWithPattern:rule options:NSRegularExpressionCaseInsensitive error:nil];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        if (firstMatch) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

///3d旋转
+(void)rotation3D:(UIView*)v Angle:(CGFloat)angle
{
    CALayer *layer = v.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}


@end
