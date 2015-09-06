//
//  img-text-img.m
//  Sd
//
//  Created by IOS on 15/8/14.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "img-text-img.h"

@implementation img_text_img

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    //CGRect leftBounds = CGRectMake(bounds.origin.x + 30, 0, 45, 44);
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}
//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + _left_padding,
                          bounds.origin.y ,
                      bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
-(void) setLeft_padding:(CGFloat)left_padding{
    _left_padding=left_padding;
}
@end
