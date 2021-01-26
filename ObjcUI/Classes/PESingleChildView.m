//
//  PESingleChildView.m
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import "PESingleChildView.h"

@implementation PESingleChildView

- (void)addSubview:(UIView *)subView
{
    if (self.subviews.count != 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [super addSubview:subView];
}

-(PESingleChildView *(^)(UIEdgeInsets padding))pe_padding
{
    return ^(UIEdgeInsets padding) {
        [self.subviews.firstObject mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(padding).priority(1000);
        }];
        return self;
    };
}

@end
