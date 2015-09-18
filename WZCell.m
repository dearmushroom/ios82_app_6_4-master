//
//  WZCell.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/18.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "WZCell.h"

#import "WZMessage.h"

#import "UITableViewCell+Func.h"

#import "UIImageView+AFNetworking.h"

@interface WZCell ()

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *messageContentLabel;

@end

@implementation WZCell

-(void)setCellInfo:(WZMessage *)message
{
    [self.userImageView setImageWithURL:message.userImageURL placeholderImage:[UIImage imageNamed:@"1.png"]];
    
    self.userNameLabel.text = message.userName;
    
    self.messageContentLabel.text = message.content;

    
}


@end
