//
//  DreamRepostResult.h
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/31/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamRepostResult : NSObject

/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;

@end
