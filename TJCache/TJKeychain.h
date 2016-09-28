//
//  TJKeychain.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/28.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJKeychain : NSObject
//保存密码到秘钥
+ (BOOL)saveAccount:(NSString *)email andPassword:(NSString *)password;
//读取
+ (NSString *)readAccount:(NSString *)email;
//删除
+ (BOOL)deleteAccount:(NSString *)email;
@end
