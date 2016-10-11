//
//  CALayer+SXAddition.h
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/17.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>



@interface CALayer (SXAdditions)



@property(nonatomic, strong) UIColor *borderColorFromUIColor;



- (void)setBorderColorFromUIColor:(UIColor *)color;



@end
