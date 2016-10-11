//
//  SXExamsTableViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/13.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXExamsTableViewController.h"
#import "SXExamsTableViewCell.h"

@interface SXExamsTableViewController ()

@end

@implementation SXExamsTableViewController
static NSString * const reuseIdentifier = @"ExamsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXExamsTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SXExamsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}


//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}


//#warning 如何才能让历届考试中的label，在选中状态时，label的背景色不变为没背景色。下面的方法不行。
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    SXExamsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.line1.backgroundColor = [UIColor redColor];
//    cell.backgroundColor = [UIColor grayColor];
//}


@end
