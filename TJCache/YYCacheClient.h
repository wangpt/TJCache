//
//  YYCacheClient.h
//  TJCache
//
//  Created by tao on 2018/9/24.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonModel;
@interface YYCacheClient : NSObject
#pragma mark - Sync
///更新用户
+ (void)updataPersonObject:(id<NSCoding>)object;
///删除用户
+ (void)removePerson;
///删除所有数据
+ (void)removeAllObjects;
///判断数据是否存在
+ (BOOL)checkPerson;
///读取用户
+ (PersonModel *)readPerson;
#pragma mark - Asyn
+ (void)updataAsynPersonObject:(id)object withBlock:(void (^)(void))block;
+ (void)removeAsynPersonWithBlock:(void (^)(NSString *key))block;
+ (void)removeAllObjectsWithBlock:(void(^)(void))block;
+ (void)checkAsynPersonWithBlock:(void (^)(NSString *key, BOOL contains))block;
+ (void)readAsynPersonWithBlock:(void (^)(NSString *key, id<NSCoding> object))block;


@end
