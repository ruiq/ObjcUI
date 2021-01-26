//
//  UIView+OCUI.m
//  pxxedu
//
//  Created by ruiq on 2020/8/14.
//  Copyright © 2020 ruiq. All rights reserved.
//

#import "UIView+OCUI.h"
#import <CoreGraphics/CoreGraphics.h>
//#import <ReactiveObjC/ReactiveObjC.h>
#import "NSArray+JKBlock.h"
#import "Masonry.h"
#import <JKCategories/UIColor+JKHEX.h>
#import <objc/runtime.h>

@implementation UIView (PE)

-(UIView *(^)(void (^configBlock)(id)))pe_config
{
    return ^(void (^configBlock)(id)) {
        configBlock(self);
        return self;
    };
}

-(instancetype)config:(void (^)(id))configBlock
{
    configBlock(self);
    return self;
}
-(instancetype)configView:(void (^)(UIView *))configBlock
{
    configBlock(self);
    return self;
}

- (UITapGestureRecognizer *)tap_
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTap_:(UITapGestureRecognizer *)tap_
{
    objc_setAssociatedObject(self, @selector(tap_), tap_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(void))tapBlock_
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTapBlock_:(void(^)(void))tapBlock_
{
    objc_setAssociatedObject(self, @selector(tapBlock_), tapBlock_, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(UIView *))constantBlock_
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setConstantBlock_:(void(^)(UIView *))constantBlock_
{
    objc_setAssociatedObject(self, @selector(constantBlock_), constantBlock_, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(UIView *(^)(void (^)(void)))pe_constants
{
    return ^(void(^onTap)(void)){
        UITapGestureRecognizer *tap = [self tap_];
        if (!tap) {
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(opTap:)];
            [self setTap_:tap];
        }
        [self setTapBlock_:onTap];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        return self;
    };
}
-(UIView *(^)(void (^)(void)))pe_onTap
{
    return ^(void(^onTap)(void)){
        UITapGestureRecognizer *tap = [self tap_];
        if (!tap) {
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(opTap:)];
            [self setTap_:tap];
        }
        [self setTapBlock_:onTap];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        return self;
    };
}

-(void)opTap:(UIGestureRecognizer *)tap
{
    void(^onTapBlock)(void) = [self tapBlock_];
    if (onTapBlock) {
        onTapBlock();
    }
}

-(UIView *(^)(CGSize))pe_size
{
    return ^(CGSize size) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}

-(UIView *(^)(CGFloat))pe_width
{
    return ^(CGFloat width) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}

-(UIView *(^)(CGFloat))pe_height
{
    return ^(CGFloat height) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}

-(UIView *(^)(CGFloat))pe_maxWidth
{
    return ^(CGFloat width) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(width).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_maxHeight
{
    return ^(CGFloat height) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(height).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_minWidth
{
    return ^(CGFloat width) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(width).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_minHeight
{
    return ^(CGFloat height) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(height).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}

-(UIView *(^)(BOOL hidden))pe_hidden
{
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

-(UIView *(^)(void))pe_cicle
{
    return ^ {
        CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGFloat minSize = MIN(size.width, size.height);
        self.layer.cornerRadius = minSize / 2.0;
        self.layer.masksToBounds = YES;
        return self;
    };
}

-(UIView *(^)(UIColor *))pe_borderColor
{
    return ^ (UIColor *borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

-(UIView *(^)(CGFloat))pe_borderWidth
{
    return ^ (CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_cornerRadius
{
    return ^ (CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}

-(UIView *(^)(UIColor *))pe_backgroundColor
{
    return ^(UIColor *color) {
        if ([UIDevice currentDevice].systemVersion.doubleValue < 14.0 && [self isKindOfClass:UIStackView.class]) {
            UIView *bgView = [self.subviews jk_detect:^BOOL(UIView *object) {
                return object.tag == kBackgroundViewTag;
            }];
            if (!bgView) {
                bgView = UIView.new;
                bgView.tag = kBackgroundViewTag;
                [self addSubview:bgView];
                [self sendSubviewToBack:bgView];
                [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(UIEdgeInsetsZero);
                }];
            }
            bgView.backgroundColor = color;
        }
        self.backgroundColor = color;
        return self;
    };
}

+(PESingleChildView *(^)(UIView *))pe_child
{
    return ^(UIView *sv) {
        PESingleChildView *view = PESingleChildView.new;
        [view addSubview:sv];
        return self;
    };
}

+(instancetype)viewWithWidth:(double)width
{
    if (width <= 0) {
        return [self spacerX];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width).priority(MASLayoutPriorityRequired);
    }];
    [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [view setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return view;

}

+(instancetype)viewWithHeight:(double)height
{
    if (height <= 0) {
        return [self spacerY];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height).priority(MASLayoutPriorityRequired);
    }];
    [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [view setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    return view;
}

+(instancetype)spacerX
{
    UIView *view = UIView.new;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
    }];
    [view setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisHorizontal];
    [view setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisHorizontal];
    return view;
}

+(instancetype)spacerY
{
    UIView *view = UIView.new;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
    }];
    [view setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisVertical];
    [view setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    return view;
}

-(UIView *(^)(UIView *))pe_addSubview
{

    return ^(UIView *sv) {
        [self addSubview:sv];
        [sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        return self;
    };}

@end
