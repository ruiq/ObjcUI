//
//  PXXViewController2.m
//  ObjcUI_Example
//
//  Created by ruiq on 2021/1/15.
//  Copyright © 2021 liruiqin. All rights reserved.
//

#import "PXXViewController2.h"
#import "PXXMyTableViewCell.h"
#import <Masonry.h>
#import <UIColor+JKRandom.h>

@interface PXXViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray<PXXUser *> *data;

@end

@implementation PXXViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:PXXMyTableViewCell.class forCellReuseIdentifier:@"a"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    NSArray *tags = @[@[],@[@"喜欢读书",@"宅属性"],@[@"爱跳舞",@"爱唱歌",@"派对达人"],@[@"单机游戏",@"吃鸡",@"单机游戏",@"吃鸡"],@[@"手游狂魔"],@[]];
    NSArray *avators = @[@"1",@"2",@"3",@"4",@"5"];
    NSArray *names = @[@"张三",@"李四",@"王五",@"六六",@"高圆圆"];
    NSArray *address = @[@"北京市海淀区上地五街5号户简介饭后漱口即恢复健户简介饭后漱口即恢复健",
                         @"上海市虹口区北京路5号户简介饭后漱口即户简介饭后漱口即恢复健",
                         @"广州市海珠区上海路10号",
                         @"深圳市南山区前海路12号",
                         @"深圳市南山区前海路12号超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址超长地址",
                         @"天津市滨海新区广州路8号"];
    NSArray *descs = @[@"用户简介饭后漱口即恢复健康生活",
                       @"用户简介饭后漱口即恢复健康生活过的世界看得见看了个德克勒克李典",
                       @"用户简介饭后漱口即恢复健康生活过的世界看得见看了个德克勒克李典看得见看了个德克勒克李典看得见看了个德克勒克李典看得见看了个德克勒克李典看得见看了个德克勒克李典看得见看了个德克勒克李典",
                       @"用户简介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活"];
    NSArray *images = @[
    @[@"图1",@"图2",@"图3",@"图4",@"图5"],
    @[@"图1"],
    @[@"图1",@"图2",@"图3"],
    @[@"图1",@"图2"],
    @[@"图1",@"图2",@"图3",@"图4"],
    @[@"图1",@"图2",@"图3",@"图4"],
    @[@"图1",@"图2",@"图3",@"图4",@"图5",@"图6",@"图7"],
    @[@"图1",@"图2",@"图3",@"图4",@"图5",@"图6",@"图7",@"图8"],
    @[@"图1",@"图2",@"图3",@"图4",@"图5",@"图6",@"图7",@"图8",@"图9"],
    @[@"图1",@"图2",@"图3",@"图4",@"图5",@"图6"],
    @[],
    @[],
    ];
    NSArray *sendTimes = @[@"刚刚",@"10分钟前",@"3小时前",@"昨天",@"12小时前"];
    
    NSMutableArray *users = NSMutableArray.array;
    for (int i = 0; i < 50; i++) {
        PXXUser *u = PXXUser.new;
        u.avator = avators[arc4random() % avators.count];
        u.name = names[arc4random() % names.count];
        u.desc = descs[arc4random() % descs.count];
        u.isFollowed = arc4random() % 2 == 1;
        u.tags = tags[arc4random() % tags.count];
        u.address = address[arc4random() % address.count];
        u.images = images[arc4random() % images.count];
        u.sendTime = sendTimes[arc4random() % sendTimes.count];
        [users addObject:u];
    }
    self.data = users;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXXMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a" forIndexPath:indexPath];
    cell.user = self.data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    self.data[indexPath.row].isFollowed = !self.data[indexPath.row].isFollowed;
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end

