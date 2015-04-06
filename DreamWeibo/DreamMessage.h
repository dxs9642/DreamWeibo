//
//  DreamMessage.h
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/5/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamMessage : NSObject

@property (nonatomic,assign) int msg_id;

@property (nonatomic,copy) NSString *receiver_id;

@property (nonatomic,copy) NSString *sender_id;

@property (nonatomic,copy) NSString *create_at;

@property (nonatomic,copy) NSString *text;


@end
