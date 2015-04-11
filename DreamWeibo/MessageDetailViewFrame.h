//
//  MessageDetailViewFrame.h
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamMessage.h"

@interface MessageDetailViewFrame : NSObject

@property (nonatomic,assign) CGRect timeFrame;

@property (nonatomic,assign) CGRect imageFrame;

@property (nonatomic,assign) CGRect msgButtonFrame;

@property (nonatomic,assign) CGRect frame;

@property (nonatomic,assign) BOOL showTime;

@property (nonatomic,strong) DreamMessage *message;




@end
