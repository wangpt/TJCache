//
//  People.h
//  FMDBTestDemo
//
//  Created by 曹小猿 on 16/8/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "Pet.h"
@protocol Pet
@end

@interface People : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSArray  *pets;
@property(nonatomic,strong)Car *car;
@end
