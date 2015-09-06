//
//  myCollectionViewCell.h
//  Sd
//
//  Created by IOS on 15/7/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myCollectionViewCellModel : NSObject
@property(nonatomic,copy) NSString * imageName;
@property(nonatomic,copy) NSString * text;
- (instancetype) initWithDic:(NSDictionary *) dic;
@end
