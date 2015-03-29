//
//  DreamSimpleFrame.h
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/29/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamSimple.h"
@class DreamStatus;
@interface DreamSimpleFrame : NSObject

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** simple数据 */
@property (nonatomic,strong) DreamSimple* simple;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;




@end
