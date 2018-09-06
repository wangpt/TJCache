//
//  TJCacheManager.h
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonModel;
@interface TJCacheManager : NSObject
///单利
+ (instancetype)sharedManager;
///数据更新
- (void)updataPersonObj:(id<NSCoding>)object;
- (PersonModel *)readPerson;

@end
