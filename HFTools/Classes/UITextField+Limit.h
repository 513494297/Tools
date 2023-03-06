//
//  UITextField+Limit.h
//
//
//  Created by fangtian on 2023/3/6.
//

#import <UIKit/UIKit.h>

typedef void(^TextLengthBlock)(NSInteger length);
typedef void(^TextLengthMaxBlock)(void);

typedef NS_ENUM(NSInteger,HFTextFieldType) {
    HFTextFieldStringType_None    = 0,      // 不限制
    HFTextFieldStringType_LimitLength,      //长度限制
    HFTextFieldStringType_NoEmoji,          // 不允许Emoji
};

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Limit)

/**输入类型*/
@property (assign, nonatomic) HFTextFieldType textFieldType;

/**允许输入最大字符长度*/
@property (assign, nonatomic) NSInteger maxLength;

/**输入长度回调（返回输入的字符长度）中文情况下不准*/
@property (nonatomic , copy) TextLengthBlock lengthBlock;

@property (nonatomic , copy) TextLengthMaxBlock maxLengthBlock;

@end

NS_ASSUME_NONNULL_END
