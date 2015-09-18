
//
//  UserManager.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "UserManager.h"

#import "AFNetworking.h"

#define zhuceURL @"http://3.xuyingtest.sinaapp.com/lyb/zhuce.php"

#define dengluURL @"http://3.xuyingtest.sinaapp.com/lyb/denglu.php"

#define setUserInfoURL @"http://3.xuyingtest.sinaapp.com/lyb/setUserInfo.php"

@interface UserManager ()

@property(nonatomic,strong)AFHTTPRequestOperationManager * afManager;

@end

@implementation UserManager

+(instancetype)share
{
    static UserManager * m = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[UserManager alloc]init];
    });
    return m;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
         NSUserDefaults * userD = [NSUserDefaults standardUserDefaults];
        
        //因token在userInfo中保存，所以就不单独保存token
//        _access_token = [userD objectForKey:@"access_token"];
        
        NSData * d = [userD objectForKey:@"userInfo"];
        User * u;
        if (d == nil)
        {
            u = [[User alloc]init];
        }
        else
        {
            u = [NSKeyedUnarchiver unarchiveObjectWithData:d];
        }
        
        _userInfo = u;
        
        self.afManager = [[AFHTTPRequestOperationManager alloc]init];
        self.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return self;
}

-(void)save
{
    NSUserDefaults * userD = [NSUserDefaults standardUserDefaults];
    
   // [userD setObject:self.access_token forKey:@"access_token"];
    /*
     The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects.
     */
    
    NSData * d = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
    
    [userD setObject:d forKey:@"userInfo"];
    
    
    //相当于保存功能
    [userD synchronize];
}


-(void)zhuceWithAccount:(NSString *)account Password:(NSString *)pw BlockHandle:(UMZ)b
{
    NSDictionary * dic = @{@"account":account,@"password":pw};
    
    [self.afManager GET:zhuceURL parameters:dic success:^void(AFHTTPRequestOperation * op, NSData * data){
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString * success = dic[@"success"];
        if ([success isEqualToString:@"0"])
        {
            b(YES);
            _userInfo.userName = account;
        }
        else
        {
            b(NO);
        }
    } failure:^void(AFHTTPRequestOperation * op, NSError * error) {
        b(NO);
    }];
    
}


-(void)loginWithAccount:(NSString *)account Password:(NSString *)pw BlockHandle:(UML)b
{
    NSDictionary * dic = @{@"account":account,@"password":pw};
    
    [self.afManager GET:dengluURL parameters:dic success:^void(AFHTTPRequestOperation * op, NSData * data){
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString * success = dic[@"success"];
        if ([success isEqualToString:@"0"])
        {
            NSString * access_token = dic[@"access_token"];
            b(access_token);
            _userInfo.userName = account;
            _userInfo.access_token = access_token;
        }
        else
        {
            b(nil);
        }
    } failure:^void(AFHTTPRequestOperation * op, NSError * error) {
        b(nil);
    }];
}

-(void)setUserName:(NSString *)name UserImage:(UIImage *)image BlockHandle:(UMZ)b
{
    NSDictionary * dic = @{@"access_token":self.access_token,@"name":name};
    
    [self.afManager POST:setUserInfoURL parameters:dic constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        if (image)
        {
            NSData * d = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:d name:@"image" fileName:@"file.png" mimeType:@"image/png"];
        }
    } success:^void(AFHTTPRequestOperation * op, NSData * data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString * success = dic[@"success"];
        if ([success isEqualToString:@"0"])
        {
            b(YES);
        }
        else
        {
            b(NO);
        }
    } failure:^void(AFHTTPRequestOperation * op, NSError * error) {
        b(NO);
    }];
}


-(NSString *)access_token
{
    return self.userInfo.access_token;
}


@end
