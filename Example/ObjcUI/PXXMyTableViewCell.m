//
//  PXXMyTableViewCell.m
//  ObjcUI_Example
//
//  Created by ruiq on 2021/1/15.
//  Copyright © 2021 liruiqin. All rights reserved.
//

#import "PXXMyTableViewCell.h"
#import <UIStackView+PEContainer.h>
#import <UIView+PE.h>
#import <UIColor+JKRandom.h>
#import <UIColor+JKHEX.h>
#import <ReactiveObjC.h>
#import <YYModel.h>
#import <Masonry.h>
#import <UIGestureRecognizer+RACSignalSupport.h>
#import <UILabel+OCUI.h>
#import <UIImageView+OCUI.h>
#import <NSArray+JKBlock.h>

@implementation PXXMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _user = PXXUser.new;
        __weak typeof(self) weakSelf = self;
        UIStackView *containerView = HStack(@[
            SpacerX(20),
            VStack(@[
                SpacerY(20),
                HStack(@[
                    Image(weakSelf.user.avator)
                    .pe_size(CGSizeMake(50, 50))
                    .pe_cicle()
                    .pe_borderColor(UIColor.lightGrayColor)
                    .pe_borderWidth(4)
                    .pe_onTap(^{
                        NSLog(@"tap avator");
                    })
                    .pe_config(^(UIImageView *v) {
                        RAC(v,image) = [RACObserve(weakSelf.user, avator) map:^id _Nullable(id  _Nullable value) {
                            return [UIImage imageNamed:value];
                        }];
                    }),
                    SpacerX(12),
                    VStack(@[
                        [weakSelf userCardWithUser:weakSelf.user],
                        SpacerY(12),
                        VStack(@[
                            [weakSelf tagContainerWithUser:weakSelf.user],
                            SpacerY(12),
                               ]).pe_config(^(UIView *v) {
                            RAC(v,hidden) = [RACObserve(weakSelf.user, tags) map:^id _Nullable(id  _Nullable value) {
                                return @([value count] == 0);
                            }];
                        }),
                        Text(weakSelf.user.desc)
                        .pe_textColor([UIColor jk_colorWithHexString:@"#333333"])
                        .pe_numberOfLines(0)
                        .pe_config(^(UILabel *v) {
                            RAC(v,text) = RACObserve(weakSelf.user, desc);
                        })
                        .pe_onTap(^{
                            NSLog(@"tap desc");
                        }),
                        SpacerY(12),
                        VStack(@[
                            [weakSelf imageViewsWithUser:weakSelf.user],
                            SpacerY(12)
                               ])
                        .pe_config(^(UIView *v) {
                            RAC(v,hidden) = [RACObserve(weakSelf.user, images) map:^id _Nullable(id  _Nullable value) {
                                return @([value count] == 0);
                            }];
                    }),
                        [weakSelf footerViewWithUser:weakSelf.user],
                        SpacerY(12),
                    ]).pe_alignment(UIStackViewAlignmentLeading),
                       ]).pe_alignment(UIStackViewAlignmentTop),
                SpacerX(0).pe_height(0.5).pe_backgroundColor(UIColor.lightGrayColor),
                   ]).pe_alignment(UIStackViewAlignmentTop),
            SpacerX(20)
        ]).pe_alignment(UIStackViewAlignmentTop);
        [self.contentView addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero).priority(1000);
            make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
        }];
        
    }
    return self;
}

-(UIView *)userCardWithUser:(PXXUser *)user
{
    return HStack(@[
        VStack(@[
                    Text(user.name)
                    .pe_textColor([UIColor jk_colorWithHexString:@"#333333"])
                    .pe_font([UIFont systemFontOfSize:14])
                    .pe_config(^(UILabel *v) {
                        RAC(v,text) = RACObserve(user, name);
                    })
                    .pe_onTap(^{
                        NSLog(@"tap name");
                    }),
                    SpacerY(8),
                    Text(user.address)
                    .pe_textColor([UIColor jk_colorWithHexString:@"#666666"])
                    .pe_font([UIFont systemFontOfSize:14])
                    .pe_numberOfLines(2)
                    .pe_config(^(UILabel *v) {
                        RAC(v,text) = RACObserve(user, address);
                    })
                    .pe_onTap(^{
                        NSLog(@"tap name");
                    }),
               ]).pe_alignment(UIStackViewAlignmentLeading),
        SpacerX(0),
        Text(user.desc)
        .pe_textColor([UIColor jk_colorWithHexString:@"#333333"])
        .pe_config(^(UILabel *v) {
            RAC(v,text) = [RACObserve(user, isFollowed) map:^id _Nullable(id  _Nullable value) {
                return [value boolValue] ? @"💖" : @"❤️";
            }];
        })
        .pe_onTap(^{
            NSLog(@"tap heart");
        user.isFollowed = !user.isFollowed;
        }),
    ]).pe_alignment(UIStackViewAlignmentTop);
}

-(UIView *)tagContainerWithUser:(PXXUser *)user
{
    __weak typeof(self) weakSelf = self;
    return HStack(@[]).pe_spacing(8).pe_config(^(UIStackView *stv) {
        [RACObserve(user, tags) subscribeNext:^(NSArray<NSString *> *x) {
            [[stv arrangedSubviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [x enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [stv addArrangedSubview:[weakSelf tagWithText:obj]];
            }];
        }];
    });
}

-(UIView *)tagWithText:(NSString *)text
{
    return
    Container(HStack(@[
        Text(@"📌").pe_font([UIFont systemFontOfSize:8]),
        SpacerX(4),
        Text(text)
        .pe_textColor(UIColor.lightGrayColor)
        .pe_font([UIFont systemFontOfSize:10])]))
    .pe_padding(UIEdgeInsetsMake(4, 8, 4, 8))
    .pe_borderWidth(0.5)
    .pe_borderColor(UIColor.lightGrayColor)
    .pe_cornerRadius(4).pe_onTap(^{
        NSLog(@"%@",text);
    });
}

-(UIView *)imageViewsWithUser:(PXXUser *)user
{
    static UIColor *imageBackgroundColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageBackgroundColor = [UIColor jk_colorWithHexString:@"#e9e9e9"];
    });
    return VStack(@[]).pe_spacing(20).pe_alignment(UIStackViewAlignmentLeading).pe_config(^(UIStackView *stv) {
        [RACObserve(user, images) subscribeNext:^(NSArray<NSString *> *x) {
            [stv.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            int rowNumder = 3;
            int columnNUmber = x.count == 4 ? 2 : 3;
            int index = 0;
            for (int rIndex = 0; rIndex < rowNumder; rIndex++) {
                UIStackView *htv = HStack(@[]).pe_spacing(20).pe_alignment(UIStackViewAlignmentLeading);
                for (int cIndex = 0; cIndex < columnNUmber; cIndex++) {
                    index = rIndex * columnNUmber + cIndex;
                    if (index < x.count) {
                        [htv addArrangedSubview:Text(x[index]).pe_textAlignment(NSTextAlignmentCenter).pe_size(CGSizeMake(80, 80)).pe_backgroundColor(imageBackgroundColor).pe_onTap(^{
                            NSLog(@"%@",x[index]);
                        })];
                    }
                    else {
                        break;
                    }
                }
                if (htv.arrangedSubviews.count > 0) {
                    [stv addArrangedSubview:htv];
                }
            }
        }];
    });
}

-(UIView *)footerViewWithUser:(PXXUser *)user
{
    return HStack(@[
        Text(user.sendTime).pe_font([UIFont systemFontOfSize:14]).pe_textColor(UIColor.grayColor).pe_config(^(UILabel *v) {
        RAC(v,text) = RACObserve(user, sendTime);
    }),
                  SpacerX(0),
        HStack(@[SpacerX(20),
                 Text(@"···").pe_font([UIFont systemFontOfSize:16]).pe_textColor(UIColor.grayColor),]).pe_onTap(^{
            NSLog(@"点击了更多按钮（横向放大点击区域）");
    })
                  ]);
}

-(void)setUser:(PXXUser *)user
{
    [_user yy_modelSetWithJSON:[user yy_modelToJSONObject]];
}

@end
