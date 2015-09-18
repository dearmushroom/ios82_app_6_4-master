//
//  TPCell.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/18.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "TPCell.h"

#import "TPMessage.h"

#import "UITableViewCell+Func.h"

#import "UIImageView+AFNetworking.h"

@interface TPCell ()

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *messageImageView;

@end

@implementation TPCell

-(void)setCellInfo:(TPMessage *)message
{
    [self.userImageView setImageWithURL:message.userImageURL placeholderImage:[UIImage imageNamed:@"1.png"]];
    
    self.userNameLabel.text = message.userName;
    
    self.messageContentLabel.text = message.content;
    
    [self.messageImageView setImageWithURL:message.messageImageURL placeholderImage:[UIImage imageNamed:@"1.png"]];
    
}

@end
