//
//  SettingUserViewController.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/18.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "SettingUserViewController.h"

#import "UserManager.h"

@interface SettingUserViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) IBOutlet UITextField *nameT;

@property(nonatomic,strong)UIImagePickerController * pickerVC;

@property(nonatomic,strong)UIImage * userImage;


@property(nonatomic,strong)UserManager * userM;

@end

@implementation SettingUserViewController

- (IBAction)tapUser:(id)sender
{
    [self presentViewController:self.pickerVC animated:YES completion:^{
        ;
    }];
}
- (IBAction)tapSave:(id)sender
{
    
    
    [self.userM setUserName:self.nameT.text UserImage:self.userImage BlockHandle:^(BOOL isSuccess) {
        if (isSuccess)
        {
            //模态展示主页
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"] animated:YES completion:nil];
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [a show];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerVC = [[UIImagePickerController alloc]init];
    self.pickerVC.delegate = self;
    
    self.userM = [UserManager share];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    self.userImage = image;
    
    [self.userButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}



@end
