//
//  TimeTool.h
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+ (NSString *)dealwithTime:(NSString *)time;

+ (BOOL)showTime:(NSString *)timeOne anotherTime:(NSString *)timeTwo;

+ (NSComparisonResult)ifOneAboveTwo:(NSString *)timeOne anotherTime:(NSString *)timeTwo;

+ (NSString *)createCurrentTime;

@end
