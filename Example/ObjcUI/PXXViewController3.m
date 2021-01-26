//
//  PXXViewController3.m
//  ObjcUI
//
//  Created by ruiq on 2021/1/18.
//  Copyright © 2021 liruiqin. All rights reserved.
//

#import "PXXViewController3.h"
#import <OCUI/OCUI.h>

@implementation PXXViewController3

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIView *containerView = VStack(@[
        SpacerY(40),
        Text(@"Header"),
        SpacerY(20),
        HStack(@[
               UIView.new.pe_size(CGSizeMake(100, 100)).pe_backgroundColor(UIColor.redColor),
               SpacerX(20),
               UIView.new.pe_size(CGSizeMake(100, 100)).pe_backgroundColor(UIColor.blueColor),
               
               ]),
        SpacerY(20),
        Text(@"Footer")
                                   ]);
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}

@end
