//
//  SXDownLoadViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/10.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXDownLoadViewController.h"

@interface SXDownLoadViewController ()

@end

@implementation SXDownLoadViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
- (IBAction)clickDownload:(id)sender {
    UITabBarController * tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabController"];
    
    NSArray * tabBarItems = tabBarController.tabBar.items;
    
        UITabBarItem * homePageTabBarItem = tabBarItems[0];
        homePageTabBarItem.image = [UIImage imageNamed:@"首页1"];
        homePageTabBarItem.selectedImage = [[UIImage imageNamed:@"首页2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * examsTabBarItem = tabBarItems[1];
        examsTabBarItem.image = [UIImage imageNamed:@"历次考试1"];
        examsTabBarItem.selectedImage = [[UIImage imageNamed:@"历次考试2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * mineTabBarItem = tabBarItems[2];
        mineTabBarItem.image = [UIImage imageNamed:@"我的1"];
        mineTabBarItem.selectedImage = [[UIImage imageNamed:@"我的2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self setNaviStyle];
    [self presentViewController:tabBarController animated:YES completion:nil];
    
    
    
}
//设置应用界面的导航栏样式
- (void)setNaviStyle
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:38.0/255 green:154.0/255 blue:229.0/255 alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}
- (IBAction)seeMistoryCode:(UIButton *)sender {
    sender.selected = !sender.selected;

}


@end
