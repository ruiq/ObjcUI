//
//  PXXUser.h
//  ObjcUI_Example
//
//  Created by ruiq on 2021/1/15.
//  Copyright © 2021 liruiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>


@interface PXXUser : NSObject<YYModel>

@property (nonatomic,copy) NSString *avator;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *sendTime;
@property (nonatomic,strong) NSArray<NSString *> *tags;
@property (nonatomic,assign) BOOL isFollowed;
// 最多9张图片
@property (nonatomic,strong) NSArray<NSString *> *images;

@end

