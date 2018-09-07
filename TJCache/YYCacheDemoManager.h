//
//  YYCacheDemoManager.h
//  TJCache
//
//  Created by tao on 2018/9/7.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonModel;

@interface YYCacheDemoManager : NSObject
///单利
+ (instancetype)sharedManager;
#pragma mark - Sync
///更新用户
- (void)updataPersonObject:(id<NSCoding>)object;
///删除用户
- (void)removePerson;
///删除所有数据
- (void)removeAllObjects;
///判断数据是否存在
+ (BOOL)checkPerson;
///读取用户
- (PersonModel *)readPerson;
@end
