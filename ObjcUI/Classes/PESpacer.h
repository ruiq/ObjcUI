//
//  PESpacer.h
//  OCUI
//
//  Created by ruiq on 2021/1/18.
//

#import <UIKit/UIKit.h>

@interface PESpacer : UIView

@property (nonatomic,assign) CGFloat value;

+(instancetype)spacerX:(CGFloat)value;
+(instancetype)spacerY:(CGFloat)value;

@end
static PESpacer * SpacerX(CGFloat value) {
    return [PESpacer spacerX:value];
}

static PESpacer * SpacerY(CGFloat value) {
    return [PESpacer spacerY:value];
}
