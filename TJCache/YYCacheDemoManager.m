//
//  YYCacheDemoManager.m
//  TJCache
//
//  Created by tao on 2018/9/7.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "YYCacheDemoManager.h"
#import "YYCache.h"

@implementation YYCacheDemoManager
static YYCacheDemoManager *sharedCacheManager = nil;
static NSString *const TJCacheName = @"PersonCache";
static NSString *const TJCacheKey= @"PersonCacheModelKey";

+ (instancetype)sharedManager {
    @synchronized(self) {
        if (sharedCacheManager == nil) {
            sharedCacheManager = [[self alloc] init];
        }
    }
    return sharedCacheManager;
}

#pragma mark - sync
- (void)updataPersonObject:(id<NSCoding>)object{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
    [cache setObject:object forKey:TJCacheKey];
}

- (void)removePerson{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    [cache removeObjectForKey:TJCacheKey];
}

- (void)removeAllObjects{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    [cache removeAllObjects];
}

+ (BOOL)checkPerson{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    return [cache containsObjectForKey:TJCacheKey];
}

- (PersonModel *)readPerson{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    PersonModel *model = (PersonModel *)[cache objectForKey:TJCacheKey];
    return model;
}
#pragma mark - Asyn
- (void)updataAsynPersonObject:(id<NSCoding>)object withBlock:(void (^)(void))block{
    YYCache *cache = [YYCache cacheWithName:TJCacheKey];
    [cache setObject:object forKey:TJCacheKey withBlock:block];
}

- (void)removeAsynPersonWithBlock:(void (^)(NSString *key))block{
    YYCache *cache = [YYCache cacheWithName:TJCacheKey];
    [cache removeObjectForKey:TJCacheKey withBlock:block];
}
- (void)removeAllObjectsWithBlock:(void(^)(void))block{
    YYCache *cache = [YYCache cacheWithName:TJCacheKey];
    [cache removeAllObjectsWithBlock:block];
}

- (void)checkAsynPersonWithBlock:(void (^)(NSString *key, BOOL contains))block{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    [cache containsObjectForKey:TJCacheKey withBlock:block];

}
- (void)readAsynPersonWithBlock:(void (^)(NSString *key, id<NSCoding> object))block{
    YYCache *cache = [YYCache cacheWithName:TJCacheName];
    [cache objectForKey:TJCacheKey withBlock:block];

}
@end
