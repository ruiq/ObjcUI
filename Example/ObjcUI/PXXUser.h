//
//  PXXUser.h
//  ObjcUI_Example
//
//  Created by ruiq on 2021/1/15.
//  Copyright © 2021 liruiqin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PXXUser : NSObject

@property (nonatomic,copy) NSString *avator;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) BOOL isFollowed;

@end

