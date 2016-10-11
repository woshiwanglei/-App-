//
//  SXAnalyzeViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/12.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXAnalyzeViewController.h"
#import "UUChart.h"

@interface SXAnalyzeViewController ()<UUChartDataSource,UITableViewDataSource,UITableViewDelegate>
{
    UUChart *chartView;
    //用于储存保存下面的label的日期字符的数组。
    NSArray *timeArray;
}


@end

@implementation SXAnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    //下面是折线图
    timeArray = @[@"7/1",@"8/20",@"9/20",@"10/20"];
    chartView = [[UUChart alloc] initwithUUChartDataFrame:CGRectMake(20, 138, WIDTH - 40, 150) withSource:self withStyle:UUChartLineStyle];
    [chartView showInView:self.view];
    
    
    
    //下面是表格
    UITableView *analyzeTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 318, WIDTH - 40, 47 * 4) style:UITableViewStylePlain];
    analyzeTableView.delegate = self;
    analyzeTableView.dataSource = self;
    [self.view addSubview:analyzeTableView];
    //表格不可滚动
    analyzeTableView.scrollEnabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = @"绵阳市第一次诊断考试";
    cell.imageView.image = [UIImage imageNamed:@"对比"];
    cell.detailTextLabel.text = @"7/1";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}



//下面是折线图的方法





#pragma mark - UUChartDataSource
//x轴有几个点
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return timeArray;
}
//y轴每个点的数值
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    return @[@[@"40",@"50",@"80",@"65"]];
}

//显示水平线
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    return CGRangeMake(100, 0);
}

@end
