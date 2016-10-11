//
//  SXLogonViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/11.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXLogonViewController.h"
#import "SXStuLogonViewController.h"
#import "SXParentsLogonViewController.h"

@interface SXLogonViewController ()
@property (nonatomic,assign) BOOL isStudent;
@property (weak, nonatomic) IBOutlet UIButton *studentBtn;
@property (weak, nonatomic) IBOutlet UIButton *parentsBtn;

@end

@implementation SXLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isStudent = YES;
    
}
- (IBAction)nextStepButton:(id)sender {
    if (self.isStudent) {
        SXStuLogonViewController *stuLogonVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyStuLogonVC"];
        [self.navigationController pushViewController:stuLogonVC animated:YES];

    }
    else
    {
        SXParentsLogonViewController *parentsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyParentsLogonVC"];
        [self.navigationController pushViewController:parentsVC animated:YES];
    }
    
    
}
- (IBAction)useAccount:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)isParentsBtn:(UIButton *)sender {
    self.parentsBtn.enabled = NO;
    self.studentBtn.enabled = YES;
    self.isStudent = NO;
}
- (IBAction)isStudentBtn:(UIButton *)sender {
    self.parentsBtn.enabled = YES;
    self.studentBtn.enabled = NO;
    self.isStudent = YES;
}




@end
