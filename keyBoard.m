//
//  keyBoard.m
//  Sd
//
//  Created by IOS on 15/7/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "keyBoard.h"
@interface keyBoard()
@property(nonatomic,assign) BOOL keyBoardIsVisible;
@end
@implementation keyBoard
- (instancetype)init{
    if (self=[super init]) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardWillShowNotification object:nil];
        [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
        _keyBoardIsVisible =NO;
    }
    return self; 
}
- (void)keyboardDidShow
{
    _keyBoardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyBoardIsVisible = NO;
}

- (BOOL)getKeyboardIsVisible
{
    return _keyBoardIsVisible;
}

@end
