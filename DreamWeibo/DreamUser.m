//
//  HMUser.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamUser.h"

@implementation DreamUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

@end