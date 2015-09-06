//
//  WMCircleProgressView.m
//  R6Watch
//
//  Created by maginawin on 15/5/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMCircleProgressView.h"

@interface WMCircleProgressView() {
    CAShapeLayer* progressLayer;
    CAShapeLayer* backgroundLayer;
    UIBezierPath* path;
    CGFloat current;
}

@end

@implementation WMCircleProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setupProgressLayerColor:(UIColor*)progressColor backgroundColor:(UIColor*)backgroundColor lineWidth:(CGFloat)lineWidth {
    
    if (!progressLayer) {
        progressLayer = [CAShapeLayer layer];
        [self.layer addSublayer:progressLayer];
    }
    if (!backgroundLayer) {
        backgroundLayer = [CAShapeLayer layer];
        [self.layer insertSublayer:backgroundLayer below:progressLayer];
    }
    if (!path) {
        path = [[UIBezierPath alloc] init];

        /*CGFloat radius = self.bounds.size.width > self.bounds.size.height ? ((((NSLayoutConstraint*)(self.constraints[0])).constant) - lineWidth) / 2 : ((((NSLayoutConstraint*)(self.constraints[0])).constant) - lineWidth) / 2;

        [path addArcWithCenter:CGPointMake((((NSLayoutConstraint*)(self.constraints[0])).constant)/2, (((NSLayoutConstraint*)(self.constraints[0])).constant)/2) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];*/
        CGFloat radius=(self.bounds.size.width-lineWidth)/2;
        [path addArcWithCenter:CGPointMake((self.bounds.size.width-lineWidth)/2,(self.bounds.size.width-lineWidth)/2) radius:radius startAngle:-M_PI_2  endAngle:M_PI_2 * 3 clockwise:YES];
            }
    progressLayer.path = path.CGPath;
    backgroundLayer.path = path.CGPath;
    
    backgroundLayer.lineWidth = lineWidth;
    backgroundLayer.strokeColor = backgroundColor.CGColor;
    backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    backgroundLayer.strokeStart = 0;
    backgroundLayer.strokeEnd = 1;
    
    
    progressLayer.lineWidth = lineWidth;
    progressLayer.strokeColor = progressColor.CGColor;
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.strokeStart = 0;
    progressLayer.strokeEnd = 0;
    progressLayer.lineCap = kCALineCapRound;
}

- (void)updateProgressCurrent:(CGFloat)aCurrent {
    if (progressLayer) {
        if (aCurrent > 1.0) {
            aCurrent = 1.0;
        } else if (aCurrent < 0) {
            aCurrent = 0;
        }
        progressLayer.strokeEnd = aCurrent;
        current = aCurrent;
    }
}

- (CGFloat)current {
    return current ? current : 0;
}

@end

