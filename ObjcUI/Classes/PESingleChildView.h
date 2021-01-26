//
//  PESingleChildView.h
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface PESingleChildView : UIView

-(PESingleChildView *(^)(UIEdgeInsets))pe_padding;

@end
static inline PESingleChildView * Container(UIView *sv) {
    PESingleChildView *sgv = PESingleChildView.new;
    [sgv addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    return sgv;
}
