//
//  UserManager.h
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "User.h"

typedef void(^UMZ)(BOOL isSuccess);

typedef void(^UML)(NSString * access_token);

@interface UserManager : NSObject

@property(nonatomic,strong,readonly)User * userInfo;

@property(nonatomic,strong,readonly)NSString * access_token;

+(instancetype)share;

-(void)save;

-(void)loginWithAccount:(NSString *)account Password:(NSString *)pw BlockHandle:(UML)b;

-(void)zhuceWithAccount:(NSString *)account Password:(NSString *)pw BlockHandle:(UMZ)b;

-(void)setUserName:(NSString *)name UserImage:(UIImage *)image BlockHandle:(UMZ)b;





@end
