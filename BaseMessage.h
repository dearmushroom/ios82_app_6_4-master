//
//  BaseMessage.h
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMessage : NSObject

/**
 *  消息ID NSNumber类型
 */
@property(nonatomic,strong)NSNumber * messageID;

/**
 *  实体处理后的字符串类型的消息ID
 */
@property(nonatomic,strong,readonly)NSString * messageIDString;

/**
 *  消息发送者昵称
 */
@property(nonatomic,strong)NSString * userName;

/**
 *  消息发送者头像URL字符串
 */
@property(nonatomic,strong)NSString * userImage;

/**
 *  消息发送者头像URL
 */
@property(nonatomic,strong,readonly)NSURL * userImageURL;

/**
 *  消息内容
 */
@property(nonatomic,strong)NSString * content;



@end
