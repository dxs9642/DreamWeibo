//
//  HMStatus.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamStatus.h"
#import "MJExtension.h"
#import "DreamPhoto.h"

@implementation DreamStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [DreamPhoto class]};
}

@end
