//
//  MessageDetailViewFrame.m
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "MessageDetailViewFrame.h"
#import "TimeTool.h"
#import "UIView+Extension.h"

@implementation MessageDetailViewFrame


- (void)setMessage:(DreamMessage *)message{
    
    _message = message;
    
    
    if (self.showTime) {
        UIFont *textFont = DreamStatusSimpleTimeFont;
        CGSize boundingSize = CGSizeMake(DreamScreenW, CGFLOAT_MAX);
        NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
        attr[NSFontAttributeName] = textFont;
        NSString *str = [TimeTool dealwithTime:message.created_at];
        CGRect timeTextFrame = [str boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        CGFloat x = DreamScreenW / 2 - timeTextFrame.size.width / 2;
        CGFloat y = 5;
        self.timeFrame = (CGRect){{x,y},timeTextFrame.size};
        
    }
    
    if (!message.isRight) {
        

    
        CGFloat x = 10;
        CGFloat y = CGRectGetMaxY(self.timeFrame) +5;
        CGSize size = CGSizeMake(30, 30);
        self.imageFrame = (CGRect){{x,y},size};
        
        CGFloat msgX = CGRectGetMaxX(self.imageFrame) + 10;
        CGFloat msgY = self.imageFrame.origin.y;
        
        CGSize boundingSize = CGSizeMake(200, CGFLOAT_MAX);
        NSAttributedString *str = self.message.attrText;
        
        CGRect msgTextFrame = [str boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        
        CGFloat msgHeight = msgTextFrame.size.height + 25;
        if (msgHeight < self.imageFrame.size.height) {
            msgHeight = self.imageFrame.size.height;
        }

        
        CGSize msgSize = CGSizeMake(msgTextFrame.size.width + 25, msgHeight);
        self.msgButtonFrame = (CGRect){{msgX,msgY},msgSize};
        

    }else{
        
        CGFloat y = CGRectGetMaxY(self.timeFrame) +5;
        CGSize size = CGSizeMake(30, 30);
        CGFloat x = DreamScreenW - 10 - size.width;
        self.imageFrame = (CGRect){{x,y},size};
        
        CGFloat msgY = self.imageFrame.origin.y;
        
        CGSize boundingSize = CGSizeMake(200, CGFLOAT_MAX);
        NSAttributedString *str = self.message.attrText;
        CGRect msgTextFrame = [str boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        
        CGFloat msgHeight = msgTextFrame.size.height + 25;
        if (msgHeight < self.imageFrame.size.height) {
            msgHeight = self.imageFrame.size.height;
        }
        
        
        CGSize msgSize = CGSizeMake(msgTextFrame.size.width + 25, msgHeight);
        CGFloat msgX = CGRectGetMinX(self.imageFrame) - 10 - msgSize.width;
        self.msgButtonFrame = (CGRect){{msgX,msgY},msgSize};
        
        
    }
    
    CGFloat width = DreamScreenW;
    CGFloat height = CGRectGetMaxY(self.msgButtonFrame) + 5;
    self.frame = CGRectMake(0, 0, width, height);

}



@end
