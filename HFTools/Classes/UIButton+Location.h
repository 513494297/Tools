//
//  UIButton+Program.h
//  YSRealModule
//
//  Created by fangtian on 2023/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 需要提前知道按钮的frameSize
@interface UIButton (Location)
/**
 设置button的图片在上，文字在下

 @param spacing 设置文字和图片的上下间距
 */
- (void)setButtonUpImageDownTextWithSpacing:(CGFloat)spacing;

/**
 设置button的图片在右，文字在左 整体靠右
 
 @param spacing 设置文字和图片的间距
 */
- (void)setButtonRightImageLeftTextWithSpacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
