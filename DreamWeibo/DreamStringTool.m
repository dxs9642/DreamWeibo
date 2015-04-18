//
//  DreamStringTool.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/9/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamStringTool.h"
#import "DreamWeibo-Swift.h"


@implementation DreamStringTool

+ (NSString *)removeSpaceChar:(NSString *)orgString{

    NSString *result = [orgString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
    
}

+ (NSString *)realText:(NSAttributedString *)attr{
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [attr enumerateAttributesInRange:NSMakeRange(0, [attr length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        DreamEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach == NULL) {
            
            [str appendString:[attr attributedSubstringFromRange:range].string];
            
        }else{
            
            [str appendString:attach.emotion.chs];
            
        }
        
        
    }];
    
    
    return str;
    
}


@end
