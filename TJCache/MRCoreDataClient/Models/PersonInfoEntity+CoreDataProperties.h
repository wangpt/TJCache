//
//  PersonInfoEntity+CoreDataProperties.h
//  TJCache
//
//  Created by tao on 2018/10/2.
//  Copyright © 2018年 王朋涛. All rights reserved.
//
//

#import "PersonInfoEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonInfoEntity (CoreDataProperties)

+ (NSFetchRequest<PersonInfoEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *infoSex;
@property (nullable, nonatomic, retain) PersonEntity *person;

@end

NS_ASSUME_NONNULL_END
