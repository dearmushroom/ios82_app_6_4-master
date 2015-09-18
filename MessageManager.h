//
//  MessageManager.h
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^MMRB)(NSArray * messages);

typedef void(^MMSB)(BOOL isSuccess);

@interface MessageManager : NSObject

+(instancetype)share;

-(void)requestMessageWithAccessToken:(NSString *)access_token BlockHandle:(MMRB)b;

-(void)sendMessageWithAccessToken:(NSString *)access_token TextContent:(NSString *)text ImageContent:(UIImage *)image BlockHandle:(MMSB)b;



@end
