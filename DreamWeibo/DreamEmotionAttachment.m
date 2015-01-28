//
//  HMEmotionAttachment.m
//  黑马微博
//
//  Created by apple on 14-7-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "DreamEmotionAttachment.h"
#import "DreamEmotion.h"

@implementation DreamEmotionAttachment

- (void)setEmotion:(DreamEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",emotion.directory,emotion.png]];
    
}

@end
