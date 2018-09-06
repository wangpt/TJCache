//
//  PersonModel.h
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfoModel.h"
@interface PersonModel : NSObject<NSCoding>
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) PersonInfoModel *infoModel;
@end
