//
//  YYCacheClient.m
//  TJCache
//
//  Created by tao on 2018/9/24.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "YYCacheClient.h"
#import "YYCache.h"
#import "PersonModel.h"
@implementation YYCacheClient
static YYCache *_dataCache;
static NSString *const TJCacheName = @"TJCacheName";

+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:TJCacheName];
}

#pragma mark - 增改
+ (void)updataObject:(id<NSCoding>)object forKey:(NSString *)key{
    [_dataCache setObject:object forKey:key];
}

+ (void)updataObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block{
    [_dataCache setObject:object forKey:key withBlock:block];
}
#pragma mark - 删除
+ (void)removeObjectForKey:(NSString *)key{
    [_dataCache removeObjectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key))block{
    [_dataCache removeObjectForKey:key withBlock:block];
}

+ (void)removeAllObjects{
    [_dataCache.diskCache removeAllObjects];
}

+ (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [_dataCache.diskCache removeAllObjectsWithBlock:block];
}

#pragma mark - 查找
+ (NSInteger)totalCost{
    return [_dataCache.diskCache totalCost];
}

+ (BOOL)containsObjectForKey:(NSString *)key{
    return [_dataCache containsObjectForKey:key];
}

+ (void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key, BOOL contains))block {
    return [_dataCache containsObjectForKey:key withBlock:block];
}

+ (id<NSCoding>)objectForKey:(NSString *)key{
    return [_dataCache objectForKey:key];
}

+ (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *key, id<NSCoding> object))block {
    [_dataCache objectForKey:key withBlock:block];
}

#pragma mark - example Sync
static NSString *const TJPersonCacheKey= @"TJPersonCacheKey";
///更新用户
+ (void)updataPersonObject:(id<NSCoding>)object{
    [self updataObject:object forKey:TJPersonCacheKey];
}

+ (void)removePerson{
    [self removeObjectForKey:TJPersonCacheKey];
 }

///判断数据是否存在
+ (BOOL)checkPerson{
    return [self containsObjectForKey:TJPersonCacheKey];
}
///读取用户
+ (PersonModel *)readPerson{
    PersonModel *model = (PersonModel *)[self objectForKey:TJPersonCacheKey];
    return model;
}
#pragma mark - example Asyn

static NSString *const TJCacheAsynKey= @"TJCacheAsynKey";

+ (void)updataAsynPersonObject:(id)object withBlock:(void (^)(void))block{
    [self updataObject:object forKey:TJCacheAsynKey withBlock:block];
}

+ (void)removeAsynPersonWithBlock:(void (^)(NSString *))block{
    [self removeObjectForKey:TJCacheAsynKey withBlock:block];
}

+ (void)checkAsynPersonWithBlock:(void (^)(NSString *key, BOOL contains))block{
    [self containsObjectForKey:TJCacheAsynKey withBlock:block];
}
+ (void)readAsynPersonWithBlock:(void (^)(NSString *key, id<NSCoding> object))block{
    [self objectForKey:TJCacheAsynKey withBlock:block];
}


@end
