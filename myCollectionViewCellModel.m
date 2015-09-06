//
//  myCollectionViewCell.m
//  Sd
//
//  Created by IOS on 15/7/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "myCollectionViewCellModel.h"
@interface myCollectionViewCellModel()

@end
@implementation myCollectionViewCellModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        self.imageName=dic[@"imageName"];
        self.text=dic[@"text"];
    }
    return  self;
}
@end
