//
//  SXHomepageViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/11.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXHomepageViewController.h"
#import "BTSpiderPlotterView.h"

@interface SXHomepageViewController ()

@end

@implementation SXHomepageViewController

#warning 这个页面的星星的根据分数来改变label的值，和改变星星的位置这个需求还没做。
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSDictionary是无序的，应用的时候不能用字典，要换成数组
    NSArray *subjectArray = @[@"语文",@"数学",@"英语",@"物理", @"化学",@"生物"];
    NSArray *schoolAverage = @[@"105",@"108",@"95",@"110",@"90",@"78"];
    NSArray *myPoint = @[@"94",@"98",@"103",@"92",@"118",@"108"];
    BTSpiderPlotterView *spiderView = [[BTSpiderPlotterView alloc] initWithFrame:CGRectMake(90, 420, WIDTH - 174 , 162) subjectArray:subjectArray andMyPoint:myPoint andSchoolAverage:schoolAverage];
    [self.view addSubview:spiderView];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
@end
