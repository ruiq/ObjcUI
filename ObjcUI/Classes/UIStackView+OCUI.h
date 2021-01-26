//
//  UIStackView+OCUI.h
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

-(UIStackView *(^)(UIStackViewAlignment))pe_alignment;
-(UIStackView *(^)(CGFloat))pe_spacing;

@end

static inline UIStackView* HStack(NSArray *subviews) {
    return [UIStackView rowWithViews:subviews];
}

static inline UIStackView* VStack(NSArray *subviews) {
    return [UIStackView columnWithViews:subviews];
}
 
