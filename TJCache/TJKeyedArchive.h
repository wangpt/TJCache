//
//  TJKeyedArchive.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/8.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
//对象归档 用来保存用户操作状态等
@interface TJKeyedArchive : NSObject
@property (copy,nonatomic) NSString *name;
@property NSInteger age;
+ (BOOL)createPerson;
+ (TJKeyedArchive *)readPerson;
@end
