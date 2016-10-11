//
//  SXSuggestViewController.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/18.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "SXSuggestViewController.h"

@interface SXSuggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *suggestTextView;
@property (weak, nonatomic) IBOutlet UITextView *placeholdLabel;

@end

@implementation SXSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建议与意见";
    self.suggestTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.suggestTextView.layer.borderWidth = 1;
    _placeholdLabel.contentInset = UIEdgeInsetsMake(-63,0,0,0);
    [_placeholdLabel setEditable:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        _placeholdLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1 && _suggestTextView.text.length == 1)
    {
        _placeholdLabel.hidden = NO;
    }
    return YES;
}
@end
