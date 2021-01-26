//
//  UILabel+OCUI.h
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import <UIKit/UIKit.h>


@interface UILabel (OCUI)

#pragma mark - 快速创建Label

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor;
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text;
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text
                numberOfLines:(NSInteger)numberOfLines;
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text
                numberOfLines:(NSInteger)numberOfLines
                textAlignment:(NSTextAlignment)textAlignment;

-(UILabel *(^)(NSString *))pe_text;
-(UILabel *(^)(UIFont *))pe_font;
-(UILabel *(^)(NSUInteger))pe_numberOfLines;
-(UILabel *(^)(UIColor *))pe_textColor;
-(UILabel *(^)(NSTextAlignment))pe_textAlignment;

@end

static inline UILabel* Text(NSString *text) {
    return UILabel.new.pe_text(text);
}
static inline UILabel* Text2(NSString *text,UIColor *textColor) {
    return UILabel.new.pe_text(text);
}
static inline UILabel* Text3(NSString *text,UIColor *textColor,UIFont *font) {
    return UILabel.new.pe_text(text);
}

