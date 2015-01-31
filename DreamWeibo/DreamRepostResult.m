//
//  DreamRepostResult.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/31/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamStatus.h"
#import "DreamRepostResult.h"

@implementation DreamRepostResult

- (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [DreamStatus class]};
}


@end
