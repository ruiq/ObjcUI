//
//  UIView+PE.h
//  pxxedu
//
//  Created by ruiq on 2020/8/14.
//  Copyright © 2020 ruiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PESingleChildView.h"

static NSUInteger const kBackgroundViewTag = 432847;
/// 宽度占位view
#define kWidth(w) [UIView viewWithWidth:w]
/// 高度占位view
#define kHeight(h) [UIView viewWithHeight:h]

/// 宽度占位view
#define SpacerX(w) [UIView viewWithWidth:w]
/// 高度占位view
#define SpacerY(h) [UIView viewWithHeight:h]

@interface UIView (PE)

/// 宽度占位view ，0表示横向填充view（placeholderX）
+(instancetype)viewWithWidth:(double)width;
/// 高度占位view ，0表示纵向填充view（placeholderY）
+(instancetype)viewWithHeight:(double)height;

+(instancetype)spacer;
+(instancetype)spacerX;
+(instancetype)spacerY;

-(instancetype)config:(void(^)(id v))configBlock;
-(instancetype)configView:(void(^)(UIView *v))configBlock;

-(UIView *(^)(void(^)(void)))pe_onTap;
-(UIView *(^)(void(^)(id)))pe_config;

-(UIView *(^)(BOOL))pe_hidden;
-(UIView *(^)(CGSize))pe_size;
-(UIView *(^)(CGFloat))pe_width;
-(UIView *(^)(CGFloat))pe_height;
-(UIView *(^)(CGFloat))pe_minWidth;
-(UIView *(^)(CGFloat))pe_minHeight;
-(UIView *(^)(CGFloat))pe_maxWidth;
-(UIView *(^)(CGFloat))pe_maxHeight;
-(UIView *(^)(UIColor *))pe_backgroundColor;
-(UIView *(^)(UIViewContentMode))pe_contentMode;
-(UIView *(^)(void))pe_cicle;
-(UIView *(^)(CGFloat))pe_cornerRadius;
-(UIView *(^)(CGFloat))pe_borderWidth;
-(UIView *(^)(UIColor *))pe_borderColor;

@end

