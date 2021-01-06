//
//  UIStackView+PEContainer.h
//  pxxedu
//
//  Created by ruiq on 2020/12/10.
//  Copyright © 2020 ruiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStackView (PEContainer)

+(instancetype)rowWithViews:(NSArray<UIView *> *)views;
+(instancetype)rowWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment;
+(instancetype)rowWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing;

+(instancetype)columnWithViews:(NSArray<UIView *> *)views;
+(instancetype)columnWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment;
+(instancetype)columnWithViews:(NSArray<UIView *> *)views alignment:(UIStackViewAlignment)alignment spacing:(CGFloat)spacing;

-(void)updateWithArrangedSubviews:(NSArray<UIView *> *)views;

@end
