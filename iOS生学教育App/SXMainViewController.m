//
//  SXMainViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/12.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXMainViewController.h"
#import "CALayer+SXAddition.h"
#import "SXChangePasswordViewController.h"
#import "SXSuggestViewController.h"

@interface SXMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SXMainViewController
#pragma mark - 更改navigationbar的高度,目前没效果，不知道原因。
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    CGRect rect = self.navigationController.navigationBar.frame;
//    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,150);
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    CGRect rect = self.navigationController.navigationBar.frame;
//    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,20);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (1 == section) {
        return 2;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.detailTextLabel.text = @"绵阳南山中学";
        cell.textLabel.text = @"所在学校";
        cell.imageView.image = [UIImage imageNamed:@"学校"];
    }
    else{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (1 == indexPath.section && 0 == indexPath.row) {
        cell.textLabel.text = @"修改密码";
        cell.imageView.image = [UIImage imageNamed:@"修改密码"];
    }
    else if (1 == indexPath.section && 1 == indexPath.row)
    {
        cell.textLabel.text = @"建议与意见";
        cell.imageView.image = [UIImage imageNamed:@"意见与建议"];
    }
    else if (2 == indexPath.section){
        cell.textLabel.text = @"关于我们";
        cell.imageView.image = [UIImage imageNamed:@"关于我们"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section && 0 == indexPath.row) {
        SXChangePasswordViewController *changePasswordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyChangePasswordVC"];
//        self.navigationController.navigationItem.backBarButtonItem.title = @" ";
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }
    if (1 == indexPath.section && 1 == indexPath.row) {
        SXSuggestViewController *suggestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MySuggestVC"];
        [self.navigationController pushViewController:suggestVC animated:YES];
    }
}


@end
