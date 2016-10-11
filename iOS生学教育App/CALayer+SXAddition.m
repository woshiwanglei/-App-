//
//  CALayer+SXAddition.m
//  iOS生学教育App
//
//  Created by 王磊 on 15/11/17.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "CALayer+SXAddition.h"
#import <objc/runtime.h>

@implementation CALayer (SXAddition)
//static const void *borderColorFromUIColorKey = &borderColorFromUIColorKey;

//@dynamic borderColorFromUIColor;



- (UIColor *)borderColorFromUIColor {
    
    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
    
}

-(void)setBorderColorFromUIColor:(UIColor *)color

{
    
    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBorderColorFromUI:[self borderColorFromUIColor]];
    
}



- (void)setBorderColorFromUI:(UIColor *)color

{
    
    self.borderColor = color.CGColor;
    
    //    NSLog(@"%@", color);
    
    
    
}


@end
