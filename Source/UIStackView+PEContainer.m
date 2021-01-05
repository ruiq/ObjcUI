//
//  UIStackView+PEContainer.m
//  pxxedu
//
//  Created by ruiq on 2020/12/10.
//  Copyright © 2020 ruiq. All rights reserved.
//

#import "UIStackView+PEContainer.h"
#import "UIView+PE.h"

@implementation UIStackView (PEContainer)

+(instancetype)rowWithViews:(NSArray<UIView *> *)views
{
    return [self rowWithViews:views alignment:UIStackViewAlignmentCenter spacing:0];
}

+(instancetype)rowWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment
{
    return [self rowWithViews:views alignment:alignment spacing:0];
}

+(instancetype)rowWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing
{
    UIStackView *view = [[UIStackView alloc] initWithArrangedSubviews:views];
    view.axis = UILayoutConstraintAxisHorizontal;
    view.spacing = spacing;
    view.alignment = alignment;
    view.distribution = UIStackViewDistributionEqualSpacing;
    view.backgroundColor = UIColor.clearColor;
    view.pe_backgroundColor(UIColor.clearColor);
    return view;
}

+(instancetype)columnWithViews:(NSArray<UIView *> *)views
{
    return [self columnWithViews:views alignment:UIStackViewAlignmentCenter spacing:0];
}

+(instancetype)columnWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment
{
    return [self columnWithViews:views alignment:alignment spacing:0];
}

+(instancetype)columnWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing
{
    UIStackView *view = [[UIStackView alloc] initWithArrangedSubviews:views];
    view.axis = UILayoutConstraintAxisVertical;
    view.spacing = spacing;
    view.alignment = alignment;
    view.distribution = UIStackViewDistributionEqualSpacing;
    view.backgroundColor = UIColor.clearColor;
    view.pe_backgroundColor(UIColor.clearColor);
    return view;
}

-(void)updateWithArrangedSubviews:(NSArray<UIView *> *)views
{
    [self.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeArrangedSubview:obj];
    }];
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != NSNull.null) {
            [self addArrangedSubview:obj];
        }
    }];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

@end
