//
//  DreamStatusOriginalFrame.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DreamStatus;

@interface DreamStatusOriginalFrame : NSObject
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 来源 */
@property (nonatomic, assign) CGRect sourceFrame;
/** 时间 */
@property (nonatomic, assign) CGRect timeFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 微博数据 */
@property (nonatomic, strong) DreamStatus *status;
@end
