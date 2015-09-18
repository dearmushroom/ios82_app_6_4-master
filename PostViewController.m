//
//  PostViewController.m
//  ios82_app_6_4
//
//  Created by ying xu on 15/9/18.
//  Copyright (c) 2015年 博看文思. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation PostViewController
- (IBAction)tapImage:(id)sender {
}
- (IBAction)tapPost:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
