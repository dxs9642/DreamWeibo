//
//  DreamMessage.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/5/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMessage.h"
#import "RegexKitLite.h"
#import "DreamRegexResult.h"
#import "DreamEmotion.h"
#import "DreamStatus.h"
#import "DreamEmotionAttachment.h"




@implementation DreamMessage


- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    // 链接、@提到、#话题#
    
    [self createAttributedText];
}



- (void)createAttributedText
{
    if (self.text == nil) return;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:    [self attributedStringWithText:self.text]];

    
    [attrStr addAttribute:NSFontAttributeName value:DreamSimpleNameFont range:NSMakeRange(0, attrStr.length)];
    
    self.attrText = attrStr;

    
}

- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        DreamRegexResult *rr = [[DreamRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        DreamRegexResult *rr = [[DreamRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];
    }];
    
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(DreamRegexResult *rr1, DreamRegexResult *rr2) {
        NSUInteger loc1 = rr1.range.location;
        NSUInteger loc2 = rr2.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
    
    [regexResults enumerateObjectsUsingBlock:^(DreamRegexResult *result, NSUInteger idx, BOOL *stop) {
    }];
    
    return regexResults;
}



- (NSAttributedString *)attributedStringWithText:(NSString *)text{
    
    // 1.匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 2.根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(DreamRegexResult *result, NSUInteger idx, BOOL *stop) {
        
        
        DreamEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [DreamStatus emotionWithDesc:result.string];
        }
        
        
        if (emotion) { // 表情
            // 创建附件对象
            DreamEmotionAttachment *attach = [[DreamEmotionAttachment alloc] init];
            
            // 传递表情
            
            attach.emotion = [DreamStatus emotionWithDesc:result.string];
            attach.bounds = CGRectMake(0, -3, DreamStatusOrginalTextFont.lineHeight, DreamStatusOrginalTextFont.lineHeight);
            
            // 将附件包装成富文本
            
            
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedText appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:DreamStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:DreamLinkText value:*capturedStrings range:*capturedRanges];
                
            }];
            
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:DreamStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:DreamLinkText value:*capturedStrings range:*capturedRanges];
                
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:DreamStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:DreamLinkText value:*capturedStrings range:*capturedRanges];
                
            }];
            
            //
            [attributedText appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value: DreamStatusRichTextFont range:NSMakeRange(0, attributedText.length)];
    
    return attributedText;
}



@end
