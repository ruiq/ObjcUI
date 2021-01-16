//
//  UIImageView+OCUI.h
//  OCUI
//
//  Created by ruiq on 2021/1/16.
//

#import <UIKit/UIKit.h>


@interface UIImageView (OCUI)


@end
static inline UIImageView* Image(NSString *named) {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
}
