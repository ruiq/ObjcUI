//
//  UIView+PE.m
//  pxxedu
//
//  Created by ruiq on 2020/8/14.
//  Copyright © 2020 ruiq. All rights reserved.
//

#import "UIView+PE.h"
#import <CoreGraphics/CoreGraphics.h>
//#import <ReactiveObjC/ReactiveObjC.h>
#import "NSArray+JKBlock.h"
#import "Masonry.h"
#import <JKCategories/UIColor+JKHEX.h>

@implementation UIView (PE)

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

/*
-(UIView *(^)(void (^)(void)))pe_onTap
{
    WS(weakSelf);
    return ^(void (^onTap)(void)){
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            if (onTap) {
                onTap();
            }
        }];
        weakSelf.userInteractionEnabled = YES;
        [weakSelf addGestureRecognizer:tap];
        return weakSelf;
    };
}
*/

-(UIView *(^)(CGSize))pe_size
{    return ^(CGSize size) {
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
            make.width.mas_greaterThanOrEqualTo(width).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_maxHeight
{
    return ^(CGFloat height) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(height).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_minWidth
{
    return ^(CGFloat width) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(width).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}
-(UIView *(^)(CGFloat))pe_minHeight
{
    return ^(CGFloat height) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(height).priority(MASLayoutPriorityRequired);
        }];
        return self;
    };
}

-(UIView *(^)(bool (^)(void)))pe_hidden
{
    return ^(bool (^hiddenBlk)(void)){
        if (hiddenBlk) {
            self.hidden = hiddenBlk();
        }
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


+(instancetype)viewWithWidth:(double)width
{
    if (width == -1) {
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
    if (height == -1) {
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

+(instancetype)spacer
{
    UIView *view = UIView.new;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MAX).priority(250);
    }];
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

+(instancetype)viewWithXib
{
    return [self viewWithXib:NSStringFromClass(self) fromBundle:[NSBundle mainBundle]];
}

+(instancetype)viewWithXib:(NSString *)xibName fromBundle:(NSBundle *)bundle
{
    
    NSArray *nib = [bundle loadNibNamed:xibName owner:self options:nil];
    //得到第一个UIView
    return nib.firstObject;
}


- (void)radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}


- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight {
    
    [self setCornerWithLeftTopCorner:leftTop
                      rightTopCorner:rigtTop
                    bottomLeftCorner:bottemLeft
                   bottomRightCorner:bottemRight
                               frame:self.bounds];
}
- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                             frame:(CGRect)frame {
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    maskPath.lineWidth = 1.0;
    maskPath.lineCapStyle = kCGLineCapRound;
    maskPath.lineJoinStyle = kCGLineJoinRound;
    [maskPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
    [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];
    
    [maskPath addQuadCurveToPoint:CGPointMake(width, height- bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
    [maskPath addLineToPoint:CGPointMake(width, rigtTop)]; //右边直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(width - rigtTop, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
    [maskPath addLineToPoint:CGPointMake(leftTop, 0)]; //顶部直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)]; //左上角圆弧
    [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)]; //左边直线
    [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

@implementation UILabel (PE)

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

@implementation UIButton (PE)

+(UIButton *)buttonWithTitle:(NSString *)title
{
    return [self buttonWithTitle:title titleColor:nil font:nil];
}

+(UIButton *)buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 22;
    [button setBackgroundColor:backgroundColor];
    [button addObserver:button forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    return button;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"enabled"]) {
        BOOL state = [change[NSKeyValueChangeNewKey] boolValue];
        if (!state) {
            self.layer.borderColor = [self titleColorForState:UIControlStateDisabled].CGColor;
        }
    }
}
#pragma mark - UIButton快速创建
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}
@end


@implementation  UIImageView (PE)
+ (instancetype)imageViewWithImageName:(NSString *)name {
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:name];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}


@end

