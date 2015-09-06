//
//  progerssBar.m
//  进度条
//
//  Created by IOS on 15/7/27.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "progressBar.h"

@implementation progressBar

/*Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor  clearColor];
        _percent = 0;
        _width = 0;
        
    }
    return self;
}
/**
 *  设置百分比
 *
 *  @param percent 百分比（0-1）
 */
- (void)setPercent:(float)percent{
    _percent= percent;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [self setProgressBarBackgroundColor];
    [self drawOutCircle];
    [self drawInteriorCircle];
    if ([_type isEqual:@"bid" ]) {
        if ([_state isEqual:@"finish"]) {
            [self setTextFull];
        }else{
            [self setTextNoFull];
        }
    }else{
        [self addCenterLabel];
    }
}

/**
 *  绘制背景色圆（外圆）
 */
- (void) setProgressBarBackgroundColor{
    CGColorRef color = (_progressBarBackgroundColor == nil) ? [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0].CGColor : _progressBarBackgroundColor.CGColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2;
   [self drawCircleWithCenter:center andRadius:radius andColor:color andEndAngle:2*M_PI];
}

/**
 *  绘制进度条进度圆
 */
- (void)drawOutCircle{
    if (_percent == 0 || _percent > 1) {
        return;
    }
    
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2;

    if (_percent == 1) {
        CGColorRef color = (_progressBarFinishColor == nil) ? bgColor.CGColor : _progressBarFinishColor.CGColor;
        [self drawCircleWithCenter:center andRadius:radius andColor:color andEndAngle:2*M_PI];
    }else{
        float endAngle = 2*M_PI*_percent;
        CGColorRef color = (_progressBarUnfinishColor  == nil) ? Color(118, 146, 232).CGColor : _progressBarUnfinishColor .CGColor;
        [self drawCircleWithCenter:center andRadius:radius andColor:color andEndAngle:endAngle];
     }
}

-(void) drawCircleWithCenter:(CGPoint) center andRadius:(CGFloat) radius andColor:(CGColorRef) color andEndAngle:(CGFloat) angle{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius,0,angle, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

/**
 *  绘制内圆
 */
-(void) drawInteriorCircle{
    float width = (_width == 0) ? 5 : _width;
    CGColorRef color = (_centerColor == nil) ? [UIColor  whiteColor].CGColor : _centerColor.CGColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2 - width;
    [self drawCircleWithCenter:center andRadius:radius andColor:color andEndAngle:2*M_PI];
}


- (void)addCenterLabel{
    NSString *percent = @"";
    float fontSize = 14;
    UIColor *cl_txt = [UIColor blueColor];
    if (_percent == 1) {
        percent = @"100%";
        fontSize = 14;
        cl_txt = (_progressBarFinishColor == nil) ? Color(189, 84, 79) : _progressBarFinishColor;
    }else if(_percent < 1 && _percent >= 0){
        fontSize = 13;
        cl_txt = (_progressBarUnfinishColor == nil) ? Color(118, 146, 232) : _progressBarUnfinishColor ;
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
    }
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary  dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,cl_txt,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
    if ([_flag isEqual:@"Y"]) {
        //CGSize cSize = [@"年" sizeWithFont:[UIFont systemFontOfSize:fontSize]];
        CGSize cSize = [@"年" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];

        CGSize cSize2 = [@"1" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
        NSString * name=@"年化";
        [name drawInRect:CGRectMake(viewSize.width/2-cSize.width, viewSize.height/2-cSize.height-cSize2.height/2+3, cSize.width*2,cSize.height) withAttributes:attributes];
    }
  }
-(void)setTextFull{
    NSString *percent = @"";
    float fontSize = 14;
    UIColor *cl_txt = [UIColor blueColor];
    if (_percent == 1) {
        percent = @"100%";
        fontSize = 14;
        cl_txt = (_progressBarFinishColor == nil) ? Color(189, 84, 79) : _progressBarFinishColor;
    }else if(_percent < 1 && _percent >= 0){
        fontSize = 13;
        cl_txt = (_progressBarUnfinishColor == nil) ? Color(118, 146, 232) : _progressBarUnfinishColor ;
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
    }
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary  dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,cl_txt,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
    if ([_flag isEqual:@"Y"]) {
        //CGSize cSize = [@"年" sizeWithFont:[UIFont systemFontOfSize:fontSize]];
        CGSize cSize = [@"标" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
        
        CGSize cSize2 = [@"1" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
        NSString * name=@"标满";
        [name drawInRect:CGRectMake(viewSize.width/2-cSize.width, viewSize.height/2-cSize.height-cSize2.height/2+3, cSize.width*2,cSize.height) withAttributes:attributes];
    }
}
- (void)setTextNoFull{
    NSString *percent = @"";
    float fontSize = 14;
    UIColor *cl_txt = [UIColor blueColor];
    if (_percent == 1) {
        percent = @"100%";
        fontSize = 14;
        cl_txt = (_progressBarFinishColor == nil) ? [UIColor greenColor] : _progressBarFinishColor;
    }else if(_percent < 1 && _percent >= 0){
        fontSize = 13;
        cl_txt = (_progressBarUnfinishColor == nil) ? Color(118, 146, 232) : _progressBarUnfinishColor ;
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
    }
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary  dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,cl_txt,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
    if ([_flag isEqual:@"Y"]) {
        //CGSize cSize = [@"年" sizeWithFont:[UIFont systemFontOfSize:fontSize]];
        CGSize cSize = [@"标" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
        
        CGSize cSize2 = [@"1" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
        NSString * name=@"未满标";
        [name drawInRect:CGRectMake(viewSize.width/2-cSize.width, viewSize.height/2-cSize.height-cSize2.height/2+3, cSize.width*2,cSize.height) withAttributes:attributes];
    }

}
@end
