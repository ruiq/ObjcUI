//
//  PESpacer.m
//  OCUI
//
//  Created by ruiq on 2021/1/18.
//

#import "PESpacer.h"
#import <Masonry/Masonry.h>

@implementation PESpacer

+(instancetype)spacerX:(CGFloat)value
{
    PESpacer *spacer = PESpacer.new;
    spacer.value = value;
    if (value <= 0) {
        [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
        }];
        [spacer setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisHorizontal];
        [spacer setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisHorizontal];
    }
    else {
        [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(value).priority(MASLayoutPriorityRequired);
        }];
        [spacer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [spacer setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return spacer;
}


+(instancetype)spacerY:(CGFloat)value
{
    PESpacer *spacer = PESpacer.new;
    spacer.value = value;
    if (value <= 0) {
        [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
        }];
        [spacer setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisVertical];
        [spacer setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    }
    else {
        [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(value).priority(MASLayoutPriorityRequired);
        }];
        [spacer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [spacer setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return spacer;
}

@end
