//
//  TJCache.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/5.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJCache : NSObject
+ (instancetype)sharedInstance;

- (void)removeObjectForKey:(id)key;

- (void)removeAllObjects;

@property (nonatomic, strong) NSCache *cache;

@end
