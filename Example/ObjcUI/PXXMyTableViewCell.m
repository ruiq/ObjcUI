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

@implementation PXXMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _user = PXXUser.new;
        __weak typeof(self) weakSelf = self;
        UIStackView *containerView = [UIStackView rowWithViews:@[
            kWidth(20),
            [UIStackView columnWithViews:@[
                kHeight(12),
                [UIStackView rowWithViews:@[
                    [UIView.new.pe_size(CGSizeMake(50, 50)).pe_backgroundColor([UIColor jk_colorWithHexString:weakSelf.user.avator]) configView:^(UIView *v) {
                    RAC(v,backgroundColor) = [RACObserve(weakSelf.user, avator) map:^id _Nullable(id  _Nullable value) {
                        return [UIColor jk_colorWithHexString:value];
                    }];
                }],
                    kWidth(20),
                    [[UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor jk_colorWithHexString:@"#333333"] text:weakSelf.user.name] config:^(UILabel *v) {
                    RAC(v,text) = RACObserve(weakSelf.user, name);
                }],
                    kWidth(-1),
                    [[UILabel labelWithFont:[UIFont systemFontOfSize:18] textColor:[UIColor jk_colorWithHexString:@"#333333"] text:@"❤️"] config:^(UILabel *v) {
                    RAC(v,text) = [RACObserve(weakSelf.user, isFollowed) map:^id _Nullable(id  _Nullable value) {
                        return [value boolValue] ? @"💖" : @"❤️";
                    }];
                }],

                ] alignment:UIStackViewAlignmentTop],
                kHeight(12),
                [[UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor jk_colorWithHexString:@"#666666"] text:weakSelf.user.name numberOfLines:0] config:^(UILabel *v) {
                RAC(v,text) = RACObserve(weakSelf.user, desc);
            }],
                kHeight(12)
            ] alignment:UIStackViewAlignmentLeading],
            kWidth(20)
        ]];
        [self.contentView addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero).priority(1000);
        }];
    }
    return self;
}

-(void)setUser:(PXXUser *)user
{
    [_user yy_modelSetWithJSON:[user yy_modelToJSONObject]];
}

@end
