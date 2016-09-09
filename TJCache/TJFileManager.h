//
//  TJFileManager.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/7.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
//属性列表  通常用于储存用户设置

@interface TJFileManager : NSObject
+(NSString *)pathForDocumentsDirectory;

/**
 *  存储数据
 *
 *  @param path    home＋地址
 *  @param content 存储数据
 *
 *  @return 是否成功
 */

+(BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content;

/**
 *  查询到的数据
 *
 *  @param path   home＋地址
 *  @param aClass 查询的类型
 *
 *  @return 查询的数据
 */
+(NSObject *)readFileAtPath:(NSString *)path withObjectClass:(Class)aClass;
/**
 *  删除数据
 *
 *  @param path home＋地址
 *
 *  @return 删除是否成功
 */
+(BOOL)removeItemAtPath:(NSString *)path;


@end
