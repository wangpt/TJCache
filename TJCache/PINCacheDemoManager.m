//
//  PINCacheDemoManager.m
//  TJCache
//
//  Created by tao on 2018/9/7.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "PINCacheDemoManager.h"
@implementation PINCacheDemoManager
static PINCacheDemoManager *sharedCacheManager = nil;
static NSString *const TJCacheName = @"TJPINCacheName";
static NSString *const TJCacheKey= @"TJPINCacheKey";

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
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache setObject:object forKey:TJCacheKey];
}

- (void)removePerson{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache removeObjectForKey:TJCacheKey];
}

- (void)removeAllObjects{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache removeAllObjects];
}

+ (BOOL)checkPerson{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    return [cache containsObjectForKey:TJCacheKey];
}

- (PersonModel *)readPerson{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    PersonModel *model = (PersonModel *)[cache objectForKey:TJCacheKey];
    return model;
}
#pragma mark - Asyn
- (void)updataAsynPersonObject:(id<NSCoding>)object withBlock:(PINCacheObjectBlock)block{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache setObject:object forKey:TJCacheKey block:block];
}

- (void)removeAsynPersonWithBlock:(PINCacheObjectBlock)block{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache removeObjectForKey:TJCacheKey block:block];
}

- (void)removeAllObjectsWithBlock:(PINCacheBlock)block{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache removeAllObjects:block];
}

+ (void)checkAsynPersonWithBlock:(PINCacheObjectContainmentBlock)block{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache containsObjectForKey:TJCacheKey block:block];
}

- (void)readAsynPersonWithBlock:(PINCacheObjectBlock)block{
    PINCache *cache = [[PINCache sharedCache] initWithName:TJCacheName];
    [cache objectForKey:TJCacheKey block:block];
}
@end
