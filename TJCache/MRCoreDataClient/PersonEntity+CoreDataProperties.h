//
//  PersonEntity+CoreDataProperties.h
//  TJCache
//
//  Created by tao on 2018/9/25.
//  Copyright © 2018年 王朋涛. All rights reserved.
//
//

#import "PersonEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonEntity (CoreDataProperties)

+ (NSFetchRequest<PersonEntity *> *)fetchRequest;

@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) PersonInfoEntity *infoModel;

@end

NS_ASSUME_NONNULL_END
