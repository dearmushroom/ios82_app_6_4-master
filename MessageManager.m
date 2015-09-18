//
//  MessageManager.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/17.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "MessageManager.h"

#import "WZMessage.h"
#import "TPMessage.h"


#import "AFNetworking.h"

#define RequestMessageURL @"http://3.xuyingtest.sinaapp.com/lyb/messageList.php"

#define SendMessageURL @"http://3.xuyingtest.sinaapp.com/lyb/postMessage.php"


@interface MessageManager ()

@property(nonatomic,strong)AFHTTPRequestOperationManager * manager;

@end


@implementation MessageManager



+(instancetype)share
{
    static MessageManager * m = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[MessageManager alloc]init];
    });
    return m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPRequestOperationManager alloc]init];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return self;
}


-(void)requestMessageWithAccessToken:(NSString *)access_token BlockHandle:(MMRB)b
{
    NSDictionary * dic = @{@"access_token":access_token};
    
    [self.manager GET:RequestMessageURL parameters:dic success:^void(AFHTTPRequestOperation * op, NSData * data) {
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray * messsages = [NSMutableArray arrayWithCapacity:arr.count];
        
        for (int i = 0; i<arr.count; i++)
        {
            BaseMessage * m = [self messageObjWithDic:arr[i]];
            [messsages addObject:m];
        }
        
        b([NSArray arrayWithArray:messsages]);
        
        
        
    } failure:^void(AFHTTPRequestOperation * op, NSError * error) {
        b(nil);
        NSLog(@"请求message失败");
        NSLog(@"%@",error.localizedDescription);
    }];
    
}


-(BaseMessage *)messageObjWithDic:(NSDictionary *)dic
{
    NSString * image = dic[@"image"];
    if ([image isEqualToString:@""] || image == nil)
    {
        //没有图片
        WZMessage * m = [[WZMessage alloc]init];
        m.userName = dic[@"username"];
        m.userImage = dic[@"userimage"];
        m.content = dic[@"content"];
        
        return m;
    }
    else
    {
        //有图
        TPMessage * m = [[TPMessage alloc]init];
        m.userName = dic[@"username"];
        m.userImage = dic[@"userimage"];
        m.content = dic[@"content"];
        m.messageImage = dic[@"image"];
        return m;
    }
}

-(void)sendMessageWithAccessToken:(NSString *)access_token TextContent:(NSString *)text ImageContent:(UIImage *)image BlockHandle:(MMSB)b
{
    NSDictionary * dic = @{@"access_token":access_token,@"content":text};
    [self.manager POST:SendMessageURL parameters:dic constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        if (image)
        {
            NSData * d = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:d name:@"image" fileName:@"file.png" mimeType:@"image/png"];
        }
    } success:^void(AFHTTPRequestOperation * op, NSData *  data) {
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

@end
