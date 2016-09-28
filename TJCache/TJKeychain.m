//
//  TJKeychain.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/28.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJKeychain.h"
#import "SSKeychain.h"
#define KEY_SERVICE @"com.tjzl.tjcache"
@implementation TJKeychain
+ (BOOL)saveAccount:(NSString *)email andPassword:(NSString *)password {
   return  [SSKeychain setPassword:password forService:KEY_SERVICE account:email];
}
+ (NSString *)readAccount:(NSString *)email{
    return [SSKeychain passwordForService:KEY_SERVICE account:email];
}

+ (BOOL)deleteAccount:(NSString *)email{
    return [SSKeychain deletePasswordForService:KEY_SERVICE account:email];
}

@end
