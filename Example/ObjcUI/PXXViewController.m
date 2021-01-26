//
//  PXXViewController.m
//  ObjcUI
//
//  Created by liruiqin on 12/30/2020.
//  Copyright (c) 2020 liruiqin. All rights reserved.
//

#import "PXXViewController.h"
#import <UIView+OCUI.h>
#import <UIStackView+OCUI.h>
#import <Masonry.h>
#import <NSArray+JKBlock.h>
#import <UILabel+OCUI.h>
#import <PESpacer.h>


@interface PXXViewController ()

@property (nonatomic,strong) NSArray *data;

@end

@implementation PXXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = @[
        @{@"title":@"房号",@"sort":@"0",@"data":@[ @"101",@"201",@"301",@"401",@"501"].mutableCopy}.mutableCopy,
        @{@"title":@"欠费周期",@"sort":@"1",@"data":@[ @"8个月",@"2个月",@"3个月",@"6个月",@"12个月"].mutableCopy}.mutableCopy,
        @{@"title":@"金额",@"sort":@"0",@"data":@[ @"1000元",@"1200元",@"1500元",@"2000元",@"1200元"].mutableCopy}.mutableCopy,
    ];
    [self createUI];
}

-(void)createUI
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIScrollView *contentView = [UIScrollView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width).priorityHigh();
    }];
    UIView *tableView = [self buildWithData:self.data];
    [contentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width).priorityHigh();
    }];
}

-(UIView *)buildWithData:(NSArray<NSDictionary *> *)data
{
    __weak typeof(self) weakSelf = self;
    return [UIStackView columnWithViews:@[
        kHeight(120),
        [UILabel labelWithFont:[UIFont systemFontOfSize:16] textColor:UIColor.blackColor text:@"测试表格"],
        kHeight(20),
        SpacerX(0).pe_height(1).pe_backgroundColor(UIColor.grayColor),
        kHeight(20),
        /// header
        [UIStackView rowWithViews:[data jk_map:^id(id object) {
        return [UIStackView rowWithViews:@[
            [UIView.new configView:^(UIView *v) {
            UIView *cView = [UIStackView rowWithViews:@[
                [UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:UIColor.blackColor text:object[@"title"]],
                kWidth(12),
                [UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:UIColor.blackColor text:[object[@"sort"] isEqualToString:@"0"] ? @"⬆️" : @"⬇️"],
            ]];
            [v addSubview:cView];
            [cView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(v);
                make.height.mas_equalTo(v);
            }];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(tap:)];
            tap.name = object[@"title"];
            v.userInteractionEnabled = YES;
            [v addGestureRecognizer:tap];
        }]
        ]].pe_width(UIScreen.mainScreen.bounds.size.width / data.count);
    }] alignment:UIStackViewAlignmentCenter],
        SpacerY(20),
        SpacerX(0).pe_height(1).pe_backgroundColor(UIColor.grayColor),
        [UIStackView rowWithViews:[data jk_map:^id(id object) {
        return [UIStackView columnWithViews:[object[@"data"] jk_map:^id(id object) {
            return [UIStackView columnWithViews:@[
                kHeight(20),
                [UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:UIColor.grayColor text:object],
                kHeight(20),
                UIView.spacerX.pe_height(1).pe_backgroundColor(UIColor.grayColor),
            ]];
        }]].pe_width(UIScreen.mainScreen.bounds.size.width / data.count);
    }]],
    ]];
}

-(void)tap:(UIGestureRecognizer *)tap
{
    NSString *title = tap.name;
    NSLog(@"%@",title);
    NSMutableArray *d = self.data.mutableCopy;
    NSMutableDictionary *targetData = [d jk_detect:^BOOL(id object) {
        return [object[@"title"] isEqualToString:title];
    }];
    NSLog(@"%@",targetData);
    targetData[@"sort"] = [targetData[@"sort"] isEqualToString:@"0"] ? @"1" : @"0";
    [targetData[@"data"] sortUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:nil ascending:[targetData[@"sort"] isEqualToString:@"0"] ? YES : NO]]];
    self.data = d;
    [self createUI];
}

@end
