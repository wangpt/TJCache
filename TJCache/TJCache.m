//
//  TJCache.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/5.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJCache.h"
@implementation TJCache

+ (instancetype)sharedInstance
{
    static TJCache *shard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[self alloc] init];
    });
    return shard;
}


- (NSCache *)cache{
    if (!_cache) {
        _cache=[[NSCache alloc]init];
        _cache.countLimit = 30;  // 设置了存放对象的最大数量
        _cache.totalCostLimit = 10 * 1024 *1024;// 设置了存放对象的大小 10mb

    }
    return _cache;
}



- (void)removeObjectForKey:(id)key{
    [self.cache removeObjectForKey:key];

}

- (void)removeAllObjects{

    [self.cache removeAllObjects];
}




@end
