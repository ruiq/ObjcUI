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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    NSArray *colors = @[@"#FFFBE6",@"#5B688A",@"#007AFF",@"#36B6FF",@"#E4E7ED"];
    NSArray *names = @[@"张三",@"李四",@"王五",@"六六",@"高圆圆"];
    NSArray *descs = @[@"用户简介饭后漱口即恢复健康生活",
                       @"用户简介饭后漱口即恢复健康生活过的世界看得见看了个德克勒克李典",
                       @"用户简介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活介饭后漱口即恢复健康生活"];
    NSMutableArray *users = NSMutableArray.array;
    for (int i = 0; i < 50; i++) {
        PXXUser *u = PXXUser.new;
        u.avator = colors[arc4random() % colors.count];
        u.name = names[arc4random() % names.count];
        u.desc = descs[arc4random() % descs.count];
        u.isFollowed = arc4random() % 2 == 1;
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
    PXXMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (!cell) {
        cell = [[PXXMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
    }
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
    self.data[indexPath.row].isFollowed = !self.data[indexPath.row].isFollowed;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end

