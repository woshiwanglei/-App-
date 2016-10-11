//
//  SXChangePasswordViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/17.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXChangePasswordViewController.h"

@interface SXChangePasswordViewController ()

@end

@implementation SXChangePasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
@end
