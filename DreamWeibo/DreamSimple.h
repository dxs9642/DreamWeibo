//
//  DreamComment.h
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DreamUser;

@interface DreamSimple : NSObject
// {"name" : "jack", "age":10}
/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;

/** 	object 	评论作者的用户信息字段 详细*/
@property (nonatomic, strong) DreamUser *user;

@end
