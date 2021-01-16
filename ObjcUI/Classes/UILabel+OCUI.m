//
//  UILabel+OCUI.m
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import "UILabel+OCUI.h"

@implementation UILabel (OCUI)

-(UILabel *(^)(NSString *))pe_text
{
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}
-(UILabel *(^)(UIFont *))pe_font
{
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}
-(UILabel *(^)(NSUInteger))pe_numberOfLines
{
    return ^(NSUInteger numberOfLines) {
        self.numberOfLines = numberOfLines;
        return self;
    };
}
-(UILabel *(^)(UIColor *))pe_textColor
{
    return ^(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}

-(UILabel *(^)(NSTextAlignment alignment))pe_textAlignment
{
    return ^(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}


#pragma mark - 快速创建Label
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor {
    return [self labelWithFont:font textColor:textColor text:@""];
}
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text {
    return [self labelWithFont:font textColor:textColor text:text numberOfLines:1];
}
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text
                numberOfLines:(NSInteger)numberOfLines {
    return [self labelWithFont:font textColor:textColor text:text numberOfLines:numberOfLines textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text
                numberOfLines:(NSInteger)numberOfLines
                textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel new];
    label.font =  font;
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    if (numberOfLines != 1) {
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    }
    return label;
}

-(void)setIcon:(UIImage *)icon space:(double)space text:(NSString *)text
{
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
    imageAttachment.image = icon;
    CGFloat imageOffsetY = -5.0;
    imageAttachment.bounds = CGRectMake(0, imageOffsetY, imageAttachment.image.size.width, imageAttachment.image.size.height);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    NSMutableAttributedString *completeText = [[NSMutableAttributedString alloc] initWithString:@""];
    [completeText appendAttributedString:attachmentString];
    NSAttributedString *textAfterIcon = [[NSAttributedString alloc] initWithString:text];
    [completeText appendAttributedString:textAfterIcon];
    self.attributedText = completeText;
}

@end
