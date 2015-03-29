//
//  DreamSimpleFrame.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/29/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamSimpleFrame.h"
#import "DreamSimple.h"
#import "DreamUser.h"

@implementation DreamSimpleFrame


- (void)setSimple:(DreamSimple *)simple
{
    _simple = simple;
    
    // 1.头像
    CGFloat iconX = DreamStatusCellInset;
    CGFloat iconY = DreamStatusCellInset;
    CGFloat iconW = 25;
    CGFloat iconH = 25;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + DreamSimpleCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [simple.user.name sizeWithFont:DreamSimpleNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (simple.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + DreamSimpleCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    
    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + DreamSimpleCellInset;
    CGFloat maxW = DreamScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:simple.attributedText];
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
        
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = DreamScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame)+DreamSimpleCellInset;
    self.cellHeight = h;
    self.frame = CGRectMake(x, y, w, h);
}

@end

