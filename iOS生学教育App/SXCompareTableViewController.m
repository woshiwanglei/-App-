//
//  SXCompareTableViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/13.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXCompareTableViewController.h"
#import "SXCompareTableViewCell.h"

@interface SXCompareTableViewController ()

@end

@implementation SXCompareTableViewController
static NSString *const reuseIdentifier = @"CompareCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXCompareTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}
- (IBAction)candelBtn:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXCompareTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.chooseImageView.highlighted = !cell.chooseImageView.highlighted;
}


@end
