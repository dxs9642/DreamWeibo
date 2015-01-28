//
//  HMEmotionAttachment.h
//  黑马微博
//
//  Created by apple on 14-7-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DreamEmotion;
@interface DreamEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) DreamEmotion *emotion;
@end
