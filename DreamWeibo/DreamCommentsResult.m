//
//  HMCommentsResult.m
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamCommentsResult.h"
#import "MJExtension.h"
#import "DreamComment.h"

@implementation DreamCommentsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [DreamComment class]};
}
@end
