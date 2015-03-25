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
    

    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + DreamStatusCellInset * 0.5;
    CGFloat maxW = DreamScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 删掉最前面的昵称
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
    if (status.isRetweeted&&!status.isFromRetweeted) {
        int len = status.user.name.length + 4;
        [text deleteCharactersInRange:NSMakeRange(0, len)];
    }
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    

    // 4.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset * 0.5;
        
        int photosCount = status.pic_urls.count;
        
        int maxCols = DreamStatusPhotosMaxCols(photosCount);
        
        // 总列数
        int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
        
        // 总行数
        int totalRows = (photosCount + maxCols - 1) / maxCols;
        
        // 计算尺寸
        CGFloat photosW = totalCols * 70 + (totalCols - 1) * 10;
        CGFloat photosH = totalRows * 70 + (totalRows - 1) * 10;
        
        CGSize photosSize = CGSizeMake(photosW, photosH);
        
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + DreamStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
    }
    
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = DreamScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
