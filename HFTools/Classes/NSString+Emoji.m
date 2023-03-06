//
//  NSString+Program.m
//  YSRealModule-YSRealPlayModule
//
//  Created by fangtian on 2023/1/31.
//

#import "NSString+Emoji.h"

#define EMOJI @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"

@implementation NSString (Emoji)

+ (BOOL)hasEmoji:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:EMOJI options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    return number > 0;
}

- (NSString *)stringByTrimmingEmoji
{
    if (![self hasEmoji]) {
        return self;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:EMOJI options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (BOOL)hasEmoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:EMOJI options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return number > 0;
}

@end
