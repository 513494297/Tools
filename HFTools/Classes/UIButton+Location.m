//
//  UIButton+Program.m
//  YSRealModule
//
//  Created by fangtian on 2023/2/7.
//

#import "UIButton+Location.h"

@implementation UIButton (Location)

/**
 设置button的图片在上，文字在下
 
 @param spacing 设置文字和图片的上下间距
 */
- (void)setButtonUpImageDownTextWithSpacing:(CGFloat)spacing {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
        
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


/**
 设置button的图片在右，文字在左 整体靠右
 
 @param spacing 设置文字和图片的间距
 */
- (void)setButtonRightImageLeftTextWithSpacing:(CGFloat)spacing{
    self.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    CGFloat titleWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = self.imageView.bounds.size.width;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing), 0, imageWidth + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleWidth + spacing, 0, -(titleWidth + spacing));
}

@end
