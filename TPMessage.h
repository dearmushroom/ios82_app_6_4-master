//
//  TPMessage.h
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "BaseMessage.h"

@interface TPMessage : BaseMessage

/**
 *  消息图片URL字符串
 */
@property(nonatomic,strong)NSString * messageImage;

/**
 *  消息图片URL
 */
@property(nonatomic,strong,readonly)NSURL * messageImageURL;


@end
