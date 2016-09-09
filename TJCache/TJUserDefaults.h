//
//  TJUserDefaults.h
//  TJCache
//
//  Created by 王朋涛 on 16/9/6.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
//preference（偏好设置）是数据持久化的几个方法中最简单的一个，常用于保存少量数据
@interface TJUserDefaults : NSObject
+ (instancetype)sharedInstance;
- (void)saveNSUserDefaults;//保存数据到NSUserDefaults
- (void)readNSUserDefaults;//从NSUserDefaults中读取数据
@end
