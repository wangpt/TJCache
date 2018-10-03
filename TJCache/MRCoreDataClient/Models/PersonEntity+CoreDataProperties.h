//
//  PersonEntity+CoreDataProperties.h
//  TJCache
//
//  Created by tao on 2018/10/2.
//  Copyright © 2018年 王朋涛. All rights reserved.
//
//

#import "PersonEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonEntity (CoreDataProperties)

+ (NSFetchRequest<PersonEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) PersonInfoEntity *infoEntity;
@property (nullable, nonatomic, retain) PersonMoreEntity *moreEntity;

@end

NS_ASSUME_NONNULL_END
