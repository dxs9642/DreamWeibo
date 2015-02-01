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
    
    
    // 2.正文
    CGFloat h = 0;
    CGFloat textX = DreamStatusCellInset;
    CGFloat textY = DreamStatusCellInset*0.3;
    CGFloat maxW = DreamScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    h = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;

    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset * 0.5;
        
        int photosCount = retweetedStatus.pic_urls.count;
        
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
    }
    
    // 3.工具条
    if (retweetedStatus.detail) { // 展示在详情里面， 需要显示toolbar
        CGFloat toolbarY = 0;
        CGFloat toolbarW = 200;
        CGFloat toolbarX = DreamScreenW - toolbarW;
        CGFloat toolbarH = 20;
        if (retweetedStatus.pic_urls.count) {
            toolbarY = CGRectGetMaxY(self.photosFrame) + DreamStatusCellInset;
        } else {
            toolbarY = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
        }
        self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        h = CGRectGetMaxY(self.toolbarFrame) + DreamStatusCellInset;
    }
    
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = DreamScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
