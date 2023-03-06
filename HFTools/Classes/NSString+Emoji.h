//
//  NSString+Program.h
//  YSRealModule-YSRealPlayModule
//
//  Created by fangtian on 2023/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Emoji)

/// 是否包含表情
+ (BOOL)hasEmoji:(NSString *)string;

/// 替换表情
- (NSString *)stringByTrimmingEmoji;

@end

NS_ASSUME_NONNULL_END
