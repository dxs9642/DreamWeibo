//
//  DreamStatus.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamStatus.h"
#import "MJExtension.h"
#import "DreamPhoto.h"
#import "NSDate+MJ.h"
#import "DreamRegexResult.h"
#import "RegexKitLite.h"
#import "DreamEmotionAttachment.h"
#import "DreamWeibo-Swift.h"
#import "DreamEmotion.h"
#import "DreamUser.h"


@implementation DreamStatus

/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;



+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        DreamEmotionTool *tool = [[DreamEmotionTool alloc] init];
        [tool setDefaultEmotions];
        _defaultEmotions = tool.defaultEmotions;
    }
    return _defaultEmotions;
}


+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        DreamEmotionTool *tool = [[DreamEmotionTool alloc] init];
        [tool setLxhEmotions];
        _lxhEmotions = tool.lxhEmotions;
    }
    return _lxhEmotions;
}


- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [DreamPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];

    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    
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

- (void)setSource:(NSString *)source
{
    
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 开始截取
    if ([source isEqual:@""]) {
        return;
    }
    
    NSString *subsource = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@", subsource];
}
/**
 *  根据字符串计算出所有的匹配结果（已经排好序）
 *
 *  @param text 字符串内容
 */
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


- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    // 链接、@提到、#话题#

[self createAttributedText];
}

- (void)setUser:(DreamUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeted_status:(DreamStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    self.retweeted = NO;
    retweeted_status.retweeted = YES;
}

- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    [self createAttributedText];
}


- (void)createAttributedText
{
    if (self.text == nil || self.user == nil) return;
    
    if (self.retweeted) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ : %@", self.user.name, self.text];
        NSAttributedString *attributedString = [self attributedStringWithText:totalText];
        self.attributedText = attributedString;
    } else {
        self.attributedText = [self attributedStringWithText:self.text];
    }
}

+ (DreamEmotion *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return nil;
    
    __block DreamEmotion *foundEmotion = nil;
    
    
    
    // 从默认表情中找
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(DreamEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    
    // 从浪小花表情中查找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(DreamEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return foundEmotion;
}

@end
