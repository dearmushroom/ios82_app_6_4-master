//
//  StartViewController.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/18.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "StartViewController.h"

#import "UserManager.h"

@interface StartViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userTextF;

@property (strong, nonatomic) IBOutlet UITextField *pwTextF;

@property(nonatomic,strong)UserManager * userM;

@property(nonatomic,strong)UIView * backgroundView;

@end

@implementation StartViewController

- (IBAction)tapLogin:(id)sender
{
    [self.userM loginWithAccount:self.userTextF.text Password:self.pwTextF.text BlockHandle:^(NSString *access_token) {
        if (access_token)
        {
            //进入设置个人信息页
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserViewController"] animated:YES];
            
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [a show];
        }
    }];
}

- (IBAction)tapZhuce:(id)sender
{
    [self.userM zhuceWithAccount:self.userTextF.text Password:self.pwTextF.text BlockHandle:^(BOOL isSuccess) {
        NSString * msg;
        if (isSuccess)
        {
            //注册成功
            msg = @"注册成功";
        }
        else
        {
            //注册失败
            msg = @"注册失败";
        }
        
        UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [a show];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userM = [UserManager share];
    
    if (self.userM.access_token)
    {
        self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.backgroundView];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.userM.access_token)
    {
        //模态展示主页
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"] animated:NO completion:nil];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.backgroundView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
