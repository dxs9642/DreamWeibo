//
//  DreamStatusOriginalFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamStatusOriginalFrame.h"
#import "DreamStatus.h"
#import "DreamUser.h"

@implementation DreamStatusOriginalFrame

- (void)setStatus:(DreamStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = DreamStatusCellInset;
    CGFloat iconY = DreamStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + DreamStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:DreamStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + DreamStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    

    
    // 5.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + DreamStatusCellInset;
    CGFloat maxW = DreamScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:DreamStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = DreamScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
