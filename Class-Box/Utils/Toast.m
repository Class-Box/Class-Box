//
//  Toast.m
//
//  Created by Yu on 15/7/31.
//

#import "Toast.h"

@interface Toast ()

@property(nonatomic)BOOL isShowLoading;

@property(nonatomic)MBProgressHUD *loadingHUD;

@property(nonatomic)NSInteger hudNum;

@property(nonatomic)UIView *bgView;

@end

@implementation Toast

+(Toast*)shareInstance
{
    static Toast *mToast=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        mToast=[[Toast alloc] init];
        
        mToast.hudNum=0;
        
        mToast.bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT/3)];
        
    });
    
    return mToast;
}

///显示纯文字(默认时间2秒)
+(void)showInfo:(NSString*)txt
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    [Toast show:view Txt:txt Duration:1.5];
}

///显示纯文字(默认时间2秒)
+(void)show:(UIView*)parentView Txt:(NSString*)txt
{
    [Toast show:parentView Txt:txt Duration:1.5];
}

///显示纯文字(自定义时间)
+(void)show:(UIView*)parentView Txt:(NSString*)txt Duration:(NSTimeInterval)time
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = txt;
    
    //如果在显示加载等待框，移动到底部显示
    if ([Toast shareInstance].isShowLoading) {
       hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    }
    
    hud.bezelView.backgroundColor=[UIColor blackColor];
    hud.label.textColor=[UIColor whiteColor];
    
    hud.delegate=[Toast shareInstance];
    [Toast shareInstance].hudNum++;
    
    [hud hideAnimated:YES afterDelay:time];
}

+(void)showLoading:(UIView*)parentView
{
    [Toast showLoading:parentView Tips:@"正在加载中..."];
}

+(void)showLoading:(UIView*)parentView Tips:(NSString*)tips
{
    [[Toast shareInstance] showLoading:parentView Tips:tips];
}

+(void)dissmiss
{
    [[Toast shareInstance] dismiss];
}

//--------------------------------------------showLoading----------------------------------------------//

-(void)showLoading:(UIView*)parentView Tips:(NSString*)tips
{
    if (!self.isShowLoading) {
        self.loadingHUD = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
        
        if (![CommonUtils isNull:tips]) {
            self.loadingHUD.label.text = tips;
        }
        
        self.loadingHUD.bezelView.backgroundColor=[UIColor blackColor];
        self.loadingHUD.label.textColor=[UIColor whiteColor];
        
        for (UIView *view in self.loadingHUD.bezelView.subviews) {
            if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                [((UIActivityIndicatorView*)view) setColor:[UIColor whiteColor]];
                break;
            }
        }
        
        self.isShowLoading=YES;
    }
}

-(void)dismiss
{
    if (self.isShowLoading) {
        if (self.loadingHUD) {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.loadingHUD hideAnimated:YES];
            });
        }
        self.isShowLoading=NO;
    }
}

//--------------------------------------------method----------------------------------------------//




//--------------------------------------------delegate----------------------------------------------//

#pragma MBProgressHUDDelegate
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    
}

@end
