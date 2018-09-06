//
//  PersonInfoModel.h
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger age;
@end