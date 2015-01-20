//
//  DreamStatusRetweetedFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamStatusRetweetedFrame.h"
#import "DreamStatus.h"
#import "DreamUser.h"



@implementation DreamStatusRetweetedFrame

- (void)setRetweetedStatus:(DreamStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = DreamStatusCellInset;
    CGFloat nameY = DreamStatusCellInset;
    CGSize nameSize = [retweetedStatus.user.name sizeWithFont:DreamStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + DreamStatusCellInset;
    CGFloat maxW = DreamScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:DreamStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = DreamScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
