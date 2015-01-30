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
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
        
        int photosCount = (int)retweetedStatus.pic_urls.count;
        CGFloat photoW = 70;
        CGFloat photoH = photoW;
        CGFloat photoMargin = 10;
        
        // 一行最多几列
        int maxCols = photosCount==4 ? 2 : 3;

        
        // 总列数
        int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
        
        // 总行数
        // 知道总个数
        // 知道每一页最多显示多少个
        // 能算出一共能显示多少页
        int totalRows = (photosCount + maxCols - 1) / maxCols;
        
        // 计算尺寸
        CGFloat photosW = totalCols * photoW + (totalCols - 1) * photoMargin;
        CGFloat photosH = totalRows * photoH + (totalRows - 1) * photoMargin;
        
        CGSize photosSize =  CGSizeMake(photosW, photosH);

        
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + DreamStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + DreamStatusCellInset;
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
