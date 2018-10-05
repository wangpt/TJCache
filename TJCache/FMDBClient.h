//
//  FMDBClient.h
//  TJCache
//
//  Created by tao on 2018/10/4.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class PersonModel;

@interface FMDBClient : NSObject
+ (void)qunueInsertPeople:(PersonModel *)people;
+ (BOOL)qunueDeleteAllData;
+ (BOOL)qunueDeletePeople:(NSString *)userId;
+ (void)qunueUpdatePeople:(PersonModel *)people;
+ (NSArray *)qunueGetPeople;
+ (BOOL)checkPerson:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
