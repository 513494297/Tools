//
//  Tools.m
//  Laundry-Steward
//
//  Created by THF on 16/7/13.
//
//

#import "Tools.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Tools


/**
 使用md5加密
 */
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

+ (MBProgressHUD *)shareMBHUD
{
    static MBProgressHUD * hud;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        hud = [[MBProgressHUD alloc]init];
    });
    return hud;
}

+ (void)showMessage:(NSString *)message
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = NO;
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

/**
 本地持久化
 */
+ (id)getObjForKey:(NSString *)key
{
    NSUserDefaults * s = [NSUserDefaults standardUserDefaults];
    return  [s objectForKey:key];
}

+ (void)setObj:(id)obj ForKey:(NSString *)key
{
    NSUserDefaults * s = [NSUserDefaults standardUserDefaults];
    [s setObject:obj forKey:key];
    [s synchronize];
}

/**
 将字典或者数组转化为JSON串
 */
+ (NSData *)toJSONData:(id)theData{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if ([jsonData length]!= 0){
        return jsonData;
    }else{
        return nil;
    }
}

/**
 去除转译字符
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:nil error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma - mark 拆分url,只返回参数
+ (NSMutableArray *)sesparateUrl:(NSString *)url
{
    int count = 0;
    NSMutableArray * allArr = [NSMutableArray array];
    NSArray * arr = [NSArray array];
    for (int i = 1; i <20; i++) {
        
        NSString * pStr = [NSString stringWithFormat:@"p%d=",i];
        if([url rangeOfString:pStr].location!= NSNotFound){
            count++;
        }
    }
    
    url = [[url componentsSeparatedByString:@"p1="]lastObject];
    
    for(int i = 1; i <= count; i++){
        arr = [url componentsSeparatedByString:[NSString stringWithFormat:@"&p%d=",i+1]];
        url = [arr lastObject];
        NSString * urlStr = [arr.firstObject stringByReplacingOccurrencesOfString:@"|" withString:@"%7c"];
        [allArr addObject:urlStr];
    }
    return allArr;
}

//拆分参数
+  (NSMutableDictionary *)sesparateParameter:(NSString *)base64Str
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray * array = [base64Str componentsSeparatedByString:@","];
    
    for(NSString * str in array){
        NSArray * a = [str componentsSeparatedByString:@":"];
        [dic setObject:a.lastObject forKey:a.firstObject];
    }
    
    return dic;
}


+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

/**
 *  压缩图片
 *
 *
 */
+ (UIImage *)scaleImage:(UIImage *)image withScale:(CGFloat)scale
{
    CGSize size = CGSizeMake(image.size.width * scale, image.size.height *scale);
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 调整图片大小
 */
+ (UIImage *)scaleToSize:(NSString *)stringName size:(CGSize)size{
    
    UIImage *img = [UIImage imageNamed:stringName];
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

/**
 按0.5缩小图片
 */
+ ( UIImage *)scaleHalfImage:(NSString *)stringName {
    
    UIImage *img = [UIImage imageNamed:stringName];
    CGSize size = img.size;
    size = CGSizeMake(size.width * 0.5, size.height * 0.5);
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

/**
 拉伸图片
 */
+ (UIImage *)starch:(NSString *)imageName wight:(CGFloat)w height:(CGFloat)h
{
    UIImage *image =[UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:w topCapHeight:h];
    return image;
    
}

@end
