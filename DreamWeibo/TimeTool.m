//
//  TimeTool.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "TimeTool.h"
#import "NSDate+MJ.h"


@implementation TimeTool

+ (NSString *)dealwithTime:(NSString *)time{
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:time];
    
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }

    
}

+ (NSString *)createCurrentTime{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    

    NSDate *date = [NSDate date];
    return [fmt stringFromDate:date];

    
}

+ (BOOL)showTime:(NSString *)timeOne anotherTime:(NSString *)timeTwo{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSDate *firstTime = [fmt dateFromString:timeOne];
    NSDate *secondTime = [fmt dateFromString:timeTwo];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *firstCmps = [calendar components:unit fromDate:firstTime];
    NSDateComponents *secondCmps = [calendar components:unit fromDate:secondTime];
    
    if (firstCmps.year != secondCmps.year) {
        return YES;
    }else if (firstCmps.month != secondCmps.month) {
            return YES;
    }else if (firstCmps.day != secondCmps.day) {
                return YES;
    }else if (firstCmps.hour != secondCmps.hour) {
                    return  YES;
    }else if (abs(firstCmps.minute - secondCmps.minute) > 5){
        return YES;
    }else{
        return NO;
    }
                    
    
}

+ (NSComparisonResult)ifOneAboveTwo:(NSString *)timeOne anotherTime:(NSString *)timeTwo{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];

    
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSDate *firstTime = [fmt dateFromString:timeOne];
    NSDate *secondTime = [fmt dateFromString:timeTwo];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *firstCmps = [calendar components:unit fromDate:firstTime];
    NSDateComponents *secondCmps = [calendar components:unit fromDate:secondTime];
    
    if (firstCmps.year > secondCmps.year) {
        return NSOrderedDescending;
    }else if (firstCmps.year < secondCmps.year){
        return NSOrderedAscending;
    }else if (firstCmps.month > secondCmps.month) {
        return NSOrderedDescending;
    }else if (firstCmps.month < secondCmps.month) {
        return NSOrderedAscending;
    }else if (firstCmps.day > secondCmps.day) {
        return NSOrderedDescending;
    }else if (firstCmps.day < secondCmps.day) {
        return NSOrderedAscending;
    }else if (firstCmps.hour > secondCmps.hour) {
        return  NSOrderedDescending;
    }else if (firstCmps.hour < secondCmps.hour) {
        return  NSOrderedAscending;
    }else if (firstCmps.minute > secondCmps.minute){
        return NSOrderedDescending;
    }else if (firstCmps.minute < secondCmps.minute){
        return NSOrderedAscending;
    }else if (firstCmps.second > secondCmps.second){
        return NSOrderedDescending;
    }else if (firstCmps.second < secondCmps.second){
        return NSOrderedAscending;
    }else{
        return NSOrderedSame;
    }
    
}



@end
