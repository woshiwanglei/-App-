//
//  ViewController.m
//  BTLibrary
//
//  Created by Byte on 5/29/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import "BTSpiderPlotterView.h"

@implementation BTSpiderPlotterView{
    //Value and key
    //NSDictionary *_valueDictionary;
    NSArray *_subjectArray;
    NSArray *_schoolAverageArray;
    NSArray *_myPointArray;
    
    CGFloat _centerX;
    CGFloat _centerY;
    	
    //Plotting and UI Array
    NSMutableArray *_pointsLengthArrayArray;
    //用于储存我的成绩的各个点坐标
    NSMutableArray *_myPointLocationArray;
    //用于储存全校平均分的各个点坐标
    NSMutableArray *_pointsToPlotArray;
}

- (id)initWithFrame:(CGRect)frame subjectArray:(NSArray *)subject andMyPoint:(NSArray *)myPoint andSchoolAverage:(NSArray *)schoolAverage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        //Private iVar
        _subjectArray = subject;
        _schoolAverageArray = schoolAverage;
        _myPointArray = myPoint;
        _pointsLengthArrayArray = [NSMutableArray array];
        _pointsToPlotArray = [NSMutableArray array];
        _myPointLocationArray = [NSMutableArray array];
        
        
        //Public iVar
        _maxValue = 150;
        //divider:阶级
        _valueDivider = 50;
        _drawboardColor = [UIColor colorWithRed:246/255.0 green:104/255.0 blue:139/255.0 alpha:0.8];
        //下面的“全校平均”的填充颜色。
        _plotColor = [UIColor colorWithRed:103 / 255.0 green:255 / 255.0 blue:164 / 255.0 alpha:1];
        
        [self calculateAllPoints];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //ref :计算
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将矩形内的区域设置为透明的
    CGContextClearRect(context, rect);
    
    // plot :图，情节
    if (YES) {
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGPoint beginPoint = [[_pointsToPlotArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(graphContext, beginPoint.x, beginPoint.y);
        for (NSValue* pointValue in _pointsToPlotArray){
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(graphContext, point.x, point.y);
        }
        //封闭当前线路
        CGContextClosePath(graphContext);
        CGContextSetFillColorWithColor(graphContext, _plotColor.CGColor);
        //CGContextFillPath(graphContext);
        CGContextSetStrokeColorWithColor(graphContext, [UIColor colorWithRed:64 / 255.0 green:255 / 255.0 blue:129 / 255.0 alpha:1].CGColor);
        CGContextSetLineWidth(graphContext, (CGFloat) 1.2);
        //CGContextStrokePath(graphContext);
        //只有用下面这种方式才能对上下文路径即进行画线，又进行填充。是不是用上下文进行绘图，调用了一种绘图方式之后（如填充），后面的绘图方式（如描线）就不再执行了？？？?
        CGContextDrawPath(graphContext,kCGPathFillStroke);
    }
    
    
    //画我的成绩透明区域
    if (YES) {
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGPoint beginPoint = [[_myPointLocationArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(graphContext, beginPoint.x, beginPoint.y);
        for (NSValue* pointValue in _myPointLocationArray){
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(graphContext, point.x, point.y);
        }
        CGContextClosePath(graphContext);
        CGContextSetFillColorWithColor(graphContext, [UIColor colorWithRed:121 / 255.0 green:190 / 255.0 blue:255 / 255.0 alpha:0.7].CGColor);
        CGContextSetStrokeColorWithColor(graphContext, [UIColor colorWithRed:49 / 255.0 green:144 / 255.0 blue:253 / 255.0 alpha:0.9].CGColor);
        CGContextSetLineWidth(graphContext, (CGFloat) 1.2);
        CGContextDrawPath(graphContext,kCGPathFillStroke);
    }
    
    
    
    // circles,绘制环绕线
    //_pointsLengthArrayArray里保存的是三个数组，每个数组里是六个同一级环的六个位置的坐标点。每个坐标点的数据类型是：CGPoint类型，分别是X和Y的坐标。
    for (NSArray *pointArray in _pointsLengthArrayArray) {
        //plot :绘制
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGPoint beginPoint = [[pointArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(graphContext, beginPoint.x, beginPoint.y);
        for (NSValue* pointValue in pointArray){
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(graphContext, point.x, point.y);
        }
        CGContextAddLineToPoint(graphContext, beginPoint.x, beginPoint.y);
        CGContextSetStrokeColorWithColor(graphContext, _drawboardColor.CGColor);
        
        CGFloat a = 1;
        CGContextSetLineDash(graphContext,0,&a,1);
        CGContextSetLineWidth(graphContext, (CGFloat) 0.88);
        CGContextStrokePath(graphContext);
    }
    
    // cuts,绘制穿插的直线
    NSArray *largestPointArray = [_pointsLengthArrayArray lastObject];
    for (NSValue* pointValue in largestPointArray){
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGContextMoveToPoint(graphContext, _centerX, _centerY);
        CGPoint point = [pointValue CGPointValue];
        CGContextAddLineToPoint(graphContext, point.x, point.y);
        CGContextSetStrokeColorWithColor(graphContext, _drawboardColor.CGColor);
        CGContextStrokePath(graphContext);
    }
    
    
}


#pragma mark - Main Function
//计算所有的值
- (void)calculateAllPoints
{
    [_pointsLengthArrayArray removeAllObjects];
    [_pointsToPlotArray removeAllObjects];
    
    //init Angle, Key and Value
    NSArray *keyArray = _subjectArray;
    NSArray *valueArray = _schoolAverageArray;
    _maxValue = [self getMaxValueFromValueArray:valueArray];
    NSArray *angleArray = [self getAngleArrayFromNumberOfSection:(int)[keyArray count]];
    
    //Calculate all the lengths
    CGFloat boundWidth = self.bounds.size.width;
    CGFloat boundHeight =  self.bounds.size.height;
    _centerX = boundWidth/2;
    _centerY = boundHeight/2;
    //下面的maxLength会传进下面的label的方法，决定下面label的大小，和label里的字的大小,还决定了蜘蛛图每条边的长度，和每个点的位置。
    CGFloat maxLength = MIN(boundWidth, boundHeight) / 2 - 1;
    int plotCircles = (_maxValue/_valueDivider);
    CGFloat lengthUnit = maxLength/plotCircles;
    NSArray *lengthArray = [self getLengthArrayWithLengthUnit:lengthUnit maxLength:maxLength];
    
    //get all the points and plot
    //lengthArray 中有三个值，所以下面的方法进三次，长度的计算没有问题，我就不要改了。。。
    for (NSNumber *lengthNumber in lengthArray) {
        CGFloat length = [lengthNumber floatValue];
        //往_pointsLengthArrayArray里添加成员，_pointsLengthArrayArray里装的是一个一个的数组。因为后面的那个方法的返回值为数组。
        //_pointsLengthArrayArray里保存的是三个数组，每个数组里是六个同一级环的六个位置的坐标点。
        [_pointsLengthArrayArray addObject:[self getPlotPointWithLength:length angleArray:angleArray]];
    }
    
    int section = 0;
    for (id value in valueArray) {
        CGFloat valueFloat = [value floatValue];
        if (valueFloat > _maxValue) {
            NSLog(@"ERROR - Value number is higher than max value - value: %f - maxValue: %f", valueFloat, _maxValue);
            return;
        }
        
        //_maxValue的值是我设置的150,但数组中有值大于我设置的150时，_maxValue的值就是数组中的最大数。
        //NSLog(@"%lf",_maxValue);
        CGFloat length = valueFloat/_maxValue * maxLength;
        CGFloat angle = [[angleArray objectAtIndex:section] floatValue];
        CGFloat x = _centerX + length*cos(angle);
        CGFloat y = _centerY + length*sin(angle);
        //_pointsToPlotArray  中保存的是每个学科的点的位置，数据类型是CGPoint
        [_pointsToPlotArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        section++;
    }
    
    
    //添加点到我的成绩的点到数组中。。。
    section = 0;
    for (id value in _myPointArray) {
        CGFloat valueFloat = [value floatValue];
        CGFloat length = valueFloat/_maxValue * maxLength;
        CGFloat angle = [[angleArray objectAtIndex:section] floatValue];
        CGFloat x = _centerX + length*cos(angle);
        CGFloat y = _centerY + length*sin(angle);
        [_myPointLocationArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        //NSLog(@"%ld",_myPointLocationArray.count);
        section++;
    }
    
    //label，
    //maxLength与label的宽度，label内部的字的大小有关，keyArray指是对key遍历后的数组，angleArray是每个key对应的角度
    [self drawLabelWithMaxLength:maxLength labelArray:keyArray angleArray:angleArray];
    
    
}

#pragma mark - Helper Function
//下面的方法是：通过传人有多少个学科的个数，返回每条线偏离角度的数组。
- (NSArray *)getAngleArrayFromNumberOfSection:(int)numberOfSection
{
    NSMutableArray *angleArray = [NSMutableArray array];
    for (int section = 0; section < numberOfSection; section++) {
        //下面进行了对section进行了加0.5，让全部角度旋转每个夹角的一半
        [angleArray addObject:[NSNumber numberWithFloat:((float)section)/(float)[_subjectArray count] * 2*M_PI - 0.5 * M_PI]];
        //NSLog(@"%lf",(float)section/(float)[_valueDictionary count] * 2*M_PI);
    }
    return angleArray;
}

- (NSArray *)getValueArrayFromDictionary:(NSDictionary *)dictionary keyArray:(NSArray *) keyArray
{
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in keyArray) {
        CGFloat value = [[dictionary objectForKey:key] floatValue];
        [valueArray addObject:[NSNumber numberWithFloat:value]];
    }
    return valueArray;
}

- (CGFloat)getMaxValueFromValueArray:(NSArray *)valueArray
{
    CGFloat maxValue = _maxValue;
    for (NSNumber *valueNumber in valueArray) {
        CGFloat valueFloat = [valueNumber floatValue];
        maxValue = valueFloat>maxValue?valueFloat:maxValue;
    }
    return ceilf(maxValue);
}

- (NSArray *)getLengthArrayWithLengthUnit:(CGFloat)lengthUnit maxLength:(CGFloat)maxLength
{
    NSMutableArray *lengthArray = [NSMutableArray array];
    for (CGFloat length = lengthUnit; length <= maxLength; length += lengthUnit) {
        [lengthArray addObject:[NSNumber numberWithFloat:length]];
    }
    return lengthArray;
}

- (NSArray *)getPlotPointWithLength:(CGFloat)length angleArray:(NSArray *)angleArray
{
    NSMutableArray *pointArray = [NSMutableArray array];
    //each length find the point，每个长度找到点
    for (NSNumber *angleNumber in angleArray) {
        CGFloat angle = [angleNumber floatValue];
        CGFloat x = _centerX + length*cos(angle);
        CGFloat y = _centerY + length*sin(angle);
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    
    //下面进了3次，每次打印结果为6，说明：angleArray中的对象个数位六个，保存的是角度。
    //NSLog(@"%ld",pointArray.count);
    //store，数组里保存的是每一个点。
    return pointArray;
}

- (void)drawLabelWithMaxLength:(CGFloat)maxLength labelArray:(NSArray *)labelArray angleArray:(NSArray *)angleArray
{
    int labelTag = 921;
    while (true) {
        UIView *label = [self viewWithTag:labelTag];
        //下面这一句为何没有打大括号。???
        if (!label) break;
        [label removeFromSuperview];
    }
    
    int section = 0;
    CGFloat fontSize = maxLength / 160 * 65.0;
    //NSLog(@"%lf,%lf",fontSize,maxLength);//50,124
    CGFloat labelLength = maxLength + maxLength/10;
    for (NSString *labelString in labelArray) {
        CGFloat angle = [[angleArray objectAtIndex:section] floatValue];
        
        CGFloat x = _centerX + labelLength*cos(angle) * 1.1;
        CGFloat y = _centerY + labelLength*sin(angle) * 1.1;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fontSize * 2, fontSize / 2)];
        label.center = CGPointMake(x, y);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:(CGFloat)(maxLength / 6)];
        //让label不旋转。
        //label.transform = CGAffineTransformMakeRotation(((float)section/[labelArray count]) * (2*M_PI) + M_PI_2);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = labelString;
        label.tag = labelTag;
        [self addSubview: label];
        //[label sizeToFit];
        section++;
    }
}

#pragma mark - setters
//- (void)setValueDivider:(CGFloat)valueDivider
//{
//    _valueDivider = valueDivider;
//    [self calculateAllPoints];
//    [self setNeedsDisplay];
//}
//
//- (void)setMaxValue:(CGFloat)maxValue
//{
//    _maxValue = maxValue;
//    [self calculateAllPoints];
//    [self setNeedsDisplay];
//}
//
//- (void)setDrawboardColor:(UIColor *)drawboardColor
//{
//    _drawboardColor = drawboardColor;
//    [self calculateAllPoints];
//    [self setNeedsDisplay];
//}
//
//- (void)setPlotColor:(UIColor *)plotColor
//{
//    _plotColor = plotColor;
//    [self calculateAllPoints];
//    [self setNeedsDisplay];
//}
//
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    if (_valueDictionary) {
//        [self calculateAllPoints];
//        [self setNeedsDisplay];
//    }
//   
//}
@end
