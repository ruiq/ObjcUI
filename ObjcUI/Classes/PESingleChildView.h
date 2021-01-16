//
//  PESingleChildView.h
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import <UIKit/UIKit.h>

@interface PESingleChildView : UIView

-(PESingleChildView *(^)(UIEdgeInsets))pe_padding;

@end
static inline PESingleChildView * Container(UIView *sv) {
    PESingleChildView *sgv = PESingleChildView.new;
    [sgv addSubview:sv];
    return sgv;
}
