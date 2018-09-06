//
//  TJCacheManager.m
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "TJCacheManager.h"
#import "YYCache.h"
@implementation TJCacheManager
static TJCacheManager *sharedCacheManager = nil;
+ (instancetype)sharedManager {
    @synchronized(self) {
        if (sharedCacheManager == nil) {
            sharedCacheManager = [[self alloc] init];
        }
    }
    return sharedCacheManager;
}

- (void)updataPersonObj:(id<NSCoding>)object{
    YYCache *cache = [YYCache cacheWithName:@"PersonCache"];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
    [cache setObject:object forKey:@"cacheModelKey"];
}
- (PersonModel *)readPerson{
    YYCache *cache = [YYCache cacheWithName:@"PersonCache"];
    PersonModel *model = (PersonModel *)[cache objectForKey:@"cacheModelKey"];
    return model;
}


@end
