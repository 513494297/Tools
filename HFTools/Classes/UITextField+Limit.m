//
//  UITextField+Limit.m
//
//
//  Created by fangtian on 2023/3/6.
//

#import "UITextField+Limit.h"
#import <objc/runtime.h>

static NSString * const HFMaxLengthKey = @"HFMaxLengthKey";
static NSString * const HFTextLengthBlockKey = @"HFTextLengthKey";
static NSString * const HFMaxLengthBlockKey = @"HFMaxLengthKey";
static NSString * const HFTextFieldTypeKey = @"HFTextFieldTypeKey";
static NSString * const HFIsTextFieldTypeKey = @"HFIsTextFieldTypeKey";

@implementation UITextField (Limit)

- (void)setMaxLength:(NSInteger)maxLength{
    objc_setAssociatedObject(self, &HFMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    self.textFieldType = HFTextFieldStringType_LimitLength;
    [self addTarget:self
             action:@selector(textFieldTextChanged:)
   forControlEvents:UIControlEventEditingChanged];
}
- (NSInteger)maxLength{
    return   [objc_getAssociatedObject(self, &HFMaxLengthKey) integerValue];
}

- (void)setLengthBlock:(TextLengthBlock)lengthBlock{
    objc_setAssociatedObject(self, &HFTextLengthBlockKey, lengthBlock, OBJC_ASSOCIATION_COPY);
    [self addTarget:self
             action:@selector(textFieldTextChanged:)
   forControlEvents:UIControlEventEditingChanged];
}
- (TextLengthBlock)lengthBlock{
    return objc_getAssociatedObject(self, &HFTextLengthBlockKey);
}

- (void)setMaxLengthBlock:(TextLengthMaxBlock)maxLengthBlock {
    objc_setAssociatedObject(self, &HFMaxLengthBlockKey, maxLengthBlock, OBJC_ASSOCIATION_COPY);
    [self addTarget:self
             action:@selector(textFieldTextChanged:)
   forControlEvents:UIControlEventEditingChanged];
}
- (TextLengthMaxBlock)maxLengthBlock{
    return objc_getAssociatedObject(self, &HFMaxLengthBlockKey);
}

- (void)setTextFieldType:(HFTextFieldType)textFieldType{
    objc_setAssociatedObject(self, &HFTextFieldTypeKey,  @(textFieldType), OBJC_ASSOCIATION_ASSIGN);
}
- (HFTextFieldType)textFieldType{
    return [objc_getAssociatedObject(self, &HFTextFieldTypeKey) integerValue];
}


- (void)lengthLimitBlock:(UITextField *)textField
{
    if (self.lengthBlock) {
        self.lengthBlock(textField.text.length);
    }
}

- (void)textFieldTextChanged:(UITextField *)textField
{
    switch (self.textFieldType) {
        case HFTextFieldStringType_None:
        {
            
        }
            break;
        case HFTextFieldStringType_LimitLength:
        {
            [self textFieldLimitLength];
        }
            break;;
        case HFTextFieldStringType_NoEmoji:
        {
            //字符串Emoji分类判断
        }
            break;
            
        default:
            break;
    }
    
   [self lengthLimitBlock:textField];
}

- (void)textFieldLimitLength {
    NSString *language = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];
    NSString *name = self.text;
    if ([language isEqualToString:@"zh-Hans"]) {
        UITextRange *range = [self markedTextRange];
        UITextPosition *start = range.start;
        UITextPosition *end = range.end;
        NSInteger selLength = [self offsetFromPosition:start toPosition:end];
        NSInteger contentLength = self.text.length - selLength;
        if (contentLength > self.maxLength) {
            self.text = [self.text substringToIndex:self.maxLength];
            if (self.maxLengthBlock) {
                self.maxLengthBlock();
            }
        }
    }else {
        if (name.length > 20) {
            self.text = [self.text substringToIndex:self.maxLength];
            if (self.maxLengthBlock) {
                self.maxLengthBlock();
            }
        }
    }
}

/**
 无限制（可以输入任何类型）
 @param textField textField
 */
- (void)textFieldStringTypeNone:(UITextField *)textField
{
    textField.text = [textField.text substringWithRange:[self getTextFieldRange:textField]];
}

/**
 获取TextField输入范围
 @param textField textField
 @return 范围
 */
- (NSRange)getTextFieldRange:(UITextField *)textField
{
    NSInteger adaptedLength = textField.maxLength > 0? MIN(textField.text.length, textField.maxLength) : MIN(textField.text.length, MAXFLOAT);
    NSRange range = NSMakeRange(0, adaptedLength);
    
    return range;
}

@end
