//
//  DreamStatusDetailFrame.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DreamStatus, DreamStatusOriginalFrame, DreamStatusRetweetedFrame;

@interface DreamStatusDetailFrame : NSObject
@property (nonatomic, strong) DreamStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) DreamStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) DreamStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;
@end
