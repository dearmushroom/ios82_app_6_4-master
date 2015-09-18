//
//  User.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "User.h"

#define Access_Token @"access_token"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.userName forKey:@"username"];
    [aCoder encodeObject:self.access_token forKey:Access_Token];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{

    self.userName = [aDecoder decodeObjectForKey:@"username"];
    self.access_token = [aDecoder decodeObjectForKey:Access_Token];
    
    return self;
}

@end
