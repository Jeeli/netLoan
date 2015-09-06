//
//  securityCode.m
//  Code
//
//  Created by IOS on 15/7/28.
//  Copyright (c) 2015年 crazypoo. All rights reserved.
//

#import "securityCode.h"
#define RandomColor  [UIColor colorWithRed:arc4random()% 256/256.0 green:arc4random()%256 / 256.0 blue:arc4random() % 256/256.0 alpha:1.0];
@interface securityCode()
@property(nonatomic,retain) NSArray * ary_Data;
@end
@implementation securityCode

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self=[super init]) {
        self.layer.cornerRadius =5.0; //设置layer圆角半径
        self.layer.masksToBounds = YES; //隐藏边界
        //设置背景色
        self.backgroundColor=[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0];
        _ary_Data=[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
        [self displaySecurityCode];  //显示一个随机验证码
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self displaySecurityCode];
    [self setNeedsDisplay];
}

- (void)displaySecurityCode
{
    NSString *getStr = [[NSString alloc] init];
    //使用initWithCapacity 当元素个数不超过容量时 添加元素不需要重新分配内存
    _securityCode = [[NSMutableString alloc] initWithCapacity:6];
    //随机从数组中选取需要个数的字符 拼接成字符串
    for(NSInteger i = 0; i < 4; i++)
    {
        NSInteger index = arc4random()%(_ary_Data.count- 1);
        getStr=[_ary_Data objectAtIndex:index];
        _securityCode=(NSMutableString *)[_securityCode stringByAppendingString:getStr];
    }
}
//UIView 初始化自动调用，调用setNeedsDisplay自动调用
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSString *text = [NSString stringWithFormat:@"%@",_securityCode];
    //CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:15]];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    int width = rect.size.width / text.length - cSize.width*3.5; //sSize*3.5 考虑文字倾斜
    int height = rect.size.height - cSize.height*1.1; //cSize*1.1 考虑文字倾斜对高度的影响
    CGPoint point;
    float pX, pY;
    //依次绘制每一个字符
    for (int i = 0; i < text.length; i++)
    {
        UIColor * color_txtForeColor=RandomColor;
        UIColor * color_txtStrokeColor=RandomColor;
        pX = arc4random()%width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        //[textC drawAtPoint:point withFont:[UIFont systemFontOfSize:20]];
        //NSStrokeColorAttributeName设置文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，这样就能使文字空心(一般空心设3.0).
        //文字阴影
        NSShadow *shadow=[[NSShadow alloc] init];
        shadow.shadowBlurRadius=5; //模糊度
        shadow.shadowColor=[UIColor yellowColor];
        shadow.shadowOffset=CGSizeMake(1, 3);
        //NSObliquenessAttributeName设置字体倾斜
        //NSExpansionAttributeName 设置文本扁平化
        NSDictionary *dic_text=@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:color_txtForeColor,
                                 NSStrokeWidthAttributeName:@-3.0,NSStrokeColorAttributeName:color_txtStrokeColor,
                                 NSShadowAttributeName:shadow,
                                 NSObliquenessAttributeName:@1,
                                 NSExpansionAttributeName:@1};
        [textC drawAtPoint:point withAttributes:dic_text];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画线宽度
    CGContextSetLineWidth(context, 1.0);
    //绘制干扰的彩色直线
    for(int cout = 0; cout <5; cout++)
    {
        UIColor * color=RandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}

@end
