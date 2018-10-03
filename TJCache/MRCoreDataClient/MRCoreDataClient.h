//
//  MRCoreDataClient.h
//  TJCache
//
//  Created by tao on 2018/10/3.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>

NS_ASSUME_NONNULL_BEGIN
@class PersonEntity;
@interface MRCoreDataClient : NSObject
///更新用户
+ (void)savePersonId:(NSString *)id name:(NSString *)name sex:(NSString *)sex;
///删除用户
+ (void)removePerson:(NSString *)id;
///删除所有数据
+ (void)removeAllObjects;
///修改用户
+ (void)updataPersonId:(NSString *)id name:(NSString *)name sex:(NSString *)sex;
///读取用户
+ (NSArray *)readAllData;
+ (PersonEntity *)readPersonId:(NSString *)id;
@end

NS_ASSUME_NONNULL_END
