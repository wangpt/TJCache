//
//  TJKeychain.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/28.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJKeychain : NSObject
+ (void)saveAccount:(NSString *)email andPassword:(NSString *)password;
+ (NSString *)readAccount:(NSString *)email;
@end
