//
//  UULineChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UULineChart.h"
#import "UUColor.h"
#import "UUChartLabel.h"


@implementation UULineChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;

    for (NSArray * ary in yLabels) {
        //ary是我们想要传的那组y轴的值，ary是内层一级的数组。
        for (NSString *valueString in ary) {
            //value就是我们想传入的一个个数。
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 5) {
        max = 5;
    }
    if (self.showRange) {
        _yValueMin = min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    
    //有多少个分数剃度，左边
    float level = (_yValueMax-_yValueMin) /5.0;
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /5.0;

    
    for (int i=0; i<6; i++) {
        //用label来画左边的剃度标记
        //UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth, UULabelHeight )];
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth, UULabelHeight * 5 / 6)];
		label.text = [NSString stringWithFormat:@"%d",(int)(level * i+_yValueMin)];
		[self addSubview:label];
    }
    //下面这个if里是什么的视图，它运行了的，通过打断点可知，但是设置不同的alpha和颜色它不会变化。为何？？？？
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight, self.frame.size.width-UUYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [self addSubview:view];
    }

    //画横线，表格的横线
    for (int i=0; i<6; i++) {
        if ([_ShowHorizonLine[i] integerValue]>0) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,UULabelHeight+i*levelHeight)];
            //[path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.12] CGColor];
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            shapeLayer.lineWidth = 1;
            //用CAShapeLayer来画虚线，实线长度与虚线长度的比为 2 比 1.
            if (i < 5) {
            [shapeLayer setLineDashPattern:
             [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
              [NSNumber numberWithInt:1],nil]];
            }
            [self.layer addSublayer:shapeLayer];
        }
    }
}
#pragma mark - 具体进行画图的入口1
-(void)setXLabels:(NSArray *)xLabels
{
//    if( !_chartLabelsForX ){
//#warning NSHashTable作用用途不懂
//        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
//    }
    
    _xLabels = xLabels;
    CGFloat num = 0;
    
    num = xLabels.count;
    
    _xLabelWidth = (self.frame.size.width - UUYLabelwidth)/num;
    
    //画折线表下面的label
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth+UUYLabelwidth, self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight)];
        label.text = labelText;
        [self addSubview:label];
        //不清楚为何一定要加到这个NSHashTable里？？？
        //[_chartLabelsForX addObject:label];
    }
    
    //画竖线
    for (int i=0; i<xLabels.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        //更改：将画竖线的起点和结束点分别加0.5个Label的宽度。
        [path moveToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth + 0.5 * _xLabelWidth,UULabelHeight)];
        [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth+ 0.5 * _xLabelWidth,self.frame.size.height-2*UULabelHeight)];
        //下面这句何用，注释掉也无影响。
        //[path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.12] CGColor];
        //下面这句何用，注释掉也无影响。
        //shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [shapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
          [NSNumber numberWithInt:1],nil]];
        [self.layer addSublayer:shapeLayer];
    }
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setShowHorizonLine:(NSMutableArray *)ShowHorizonLine
{
    _ShowHorizonLine = ShowHorizonLine;
}

#pragma mark - 具体进行画图的入口2
-(void)strokeChart
{
    //_yValues.count = 1。在我的这个项目中，永远等于1.。。
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i;
        NSInteger min_i;
        //算出数组中的最大最小值。
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //画折线
        //CAShapeLayer
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 1.3;
        _chartLine.strokeEnd   = 0.0;
        //仅仅是画线，与画的圆圈无关
        [self.layer addSublayer:_chartLine];
        
        //画透明区域的CGShapeLayer
        CAShapeLayer *_chartLine1 = [CAShapeLayer layer];
        _chartLine1.lineCap = kCALineCapRound;
        _chartLine1.lineJoin = kCALineJoinBevel;
        //下面这一句用于设置透明区域的颜色
        _chartLine1.strokeColor = [[UIColor clearColor] CGColor];
        _chartLine1.fillColor   = [[UIColor colorWithRed:206 / 255.0 green:233 / 255.0 blue:255 / 255.0 alpha:0.7] CGColor];
        _chartLine1.lineWidth   = 1.3;
        _chartLine1.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine1];
        
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        //第一个点x轴位置
        CGFloat xPosition = (UUYLabelwidth + _xLabelWidth/2.0);
        //下面为整个图标区的高度，图标区的上面，有一个UULabelHeight的高度，下面有两个UULabelHeight的高度
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        //第一个值占总范围的比例值
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
       
        
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        //我没让它显示最大值和最小值，代理的方法返回值为NO，这里的ShowMaxMinArray为nil，所以if里面的东西不用看。
//        if (self.ShowMaxMinArray) {
//            if ([self.ShowMaxMinArray[i] intValue]>0) {
//                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
//            }else{
//                isShowMaxAndMinPoint = YES;
//            }
//        }
        
        
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];

        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
        
        //画透明填充,创建画笔
        UIBezierPath *fillArea = [UIBezierPath bezierPath];
        
        
        
        
        
        //为何下面这一句更改线的宽度起不到效果，而上面可以更改到这根线的宽度？？？
        //[progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;//用于设置第一次不进if里
        float lastGrade = 0;//用于储存上一个点的y值
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                [progressline addLineToPoint:point];
                
                //透明填充
                [fillArea moveToPoint:CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
                [fillArea addLineToPoint:CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight + UULabelHeight)];
                [fillArea addLineToPoint:CGPointMake(xPosition + (index - 1) * _xLabelWidth,  chartCavanHeight + UULabelHeight)];
                [fillArea addLineToPoint:CGPointMake(xPosition + (index - 1) * _xLabelWidth, chartCavanHeight - lastGrade * chartCavanHeight+UULabelHeight)];
                
                
                [fillArea closePath];
                //下面这一句来设置颜色是没有效果的
                //[[UIColor blueColor] setFill];
                //下面这一句为何也没用
                //[fillArea fill];
                
                
                BOOL isShowMaxAndMinPoint = YES;
                //理由同上，我在代理中返回的是NO，不用看这个if
//                if (self.ShowMaxMinArray) {
//                    if ([self.ShowMaxMinArray[i] intValue]>0) {
//                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
//                    }else{
//                        isShowMaxAndMinPoint = YES;
//                    }
//                }
//                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
                
//                [progressline stroke];
            }
            index += 1;
            lastGrade = grade;
        }
        
        //下面这一句是什么鬼？？？
        _chartLine.path = progressline.CGPath;
        //将bezierPath的CGPath赋值给caShapeLayer的path
        _chartLine1.path = fillArea.CGPath;
        
        
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        }else{
            //折线的颜色
            _chartLine.strokeColor = [SXLineColor CGColor];
        }
        
        //画线的动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        //添加画线这个动画，用的是KVO设计模式
        //[_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
        _chartLine1.strokeEnd = 1.0;
    }
    //将下面的表格的虚线放到折线透明区域的上面,目前不成功，有时间再改。。
//    [self setYLabels:_yValues];
//    [self setXLabels:_xLabels];
    
}
//point:点的位置    index：在数组中的排号     value：第一个点的y轴数值
//下面是添加圆圈的方法
- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    //view的大小
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11, 11.2)];
    view.center = point;
    view.layer.masksToBounds = YES;
    //圆角矩形的半径，线宽，线颜色。
    view.layer.cornerRadius = 6;
    view.layer.borderWidth = 1.7;
    //SXLineColor是我自定义的宏的颜色。
    view.layer.borderColor = [[_colors objectAtIndex:index] CGColor]?[[_colors objectAtIndex:index] CGColor]:SXLineColor.CGColor;
    
    //hollow：空心，这个第三方库中，如果要显示最大值和最小值，最大值和最小值就是实心。
    if (isHollow) {
        //圆圈中间的颜色
        view.backgroundColor = [UIColor whiteColor];
    }
    //我的工程里用不到实心这个功能，else里对我没用。
    else{
        view.backgroundColor = [_colors objectAtIndex:index]?[_colors objectAtIndex:index]:SXLineColor;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, point.y-UULabelHeight*2, UUTagLabelwidth, UULabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

@end
