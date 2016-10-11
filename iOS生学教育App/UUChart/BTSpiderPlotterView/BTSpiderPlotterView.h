//
//  ViewController.m
//  BTLibrary
//
//  Created by Byte on 5/29/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BTSpiderPlotterView : UIView


- (id)initWithFrame:(CGRect)frame subjectArray:(NSArray *)subject andMyPoint:(NSArray *)myPoint andSchoolAverage:(NSArray *)schoolAverage;

@property (nonatomic, assign) CGFloat valueDivider; // default 1
@property (nonatomic, assign) CGFloat maxValue; // default to the highest value in the dictionary
@property (nonatomic, strong) UIColor *drawboardColor;
@property (nonatomic, strong) UIColor *plotColor; 

@end
