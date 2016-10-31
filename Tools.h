//
//  Tools.h
//  Laundry-Steward
//
//  Created by THF on 16/7/13.
//
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
/**
 使用md5加密
 */
+ (NSString *)md5:(NSString *)str;

+ (void)showMessage:(NSString *)message;
/**
 本地持久化
 */
+ (id)getObjForKey:(NSString *)key;

+ (void)setObj:(id)obj ForKey:(NSString *)key;

/**
 将字典或者数组转化为JSON串
 */
+ (NSData *)toJSONData:(id)theData;

/**
 去除转译字符
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 拆分字符串
 */
+ (NSMutableArray *)sesparateUrl:(NSString *)url;

/**
 拆分参数
 */
+  (NSMutableDictionary *)sesparateParameter:(NSString *)base64Str;

\
/**
 *  压缩图片
 *
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 调整图片大小
 */
+ ( UIImage *)scaleToSize:(NSString *)stringName size:(CGSize)size;

/**
 按0.5缩小图片
 */
+ ( UIImage *)scaleHalfImage:(NSString *)stringName;

/**
 拉伸图片
 */
+ (UIImage *)starch:(NSString *)imageName wight:(CGFloat)w height:(CGFloat)h;


@end
