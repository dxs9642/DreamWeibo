//
//  DreamStringTool.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/9/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamStringTool.h"

@implementation DreamStringTool

+ (NSString *)removeSpaceChar:(NSString *)orgString{

    NSString *result = [orgString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
    
}


@end
