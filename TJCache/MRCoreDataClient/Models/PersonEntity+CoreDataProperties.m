//
//  PersonEntity+CoreDataProperties.m
//  TJCache
//
//  Created by tao on 2018/10/2.
//  Copyright © 2018年 王朋涛. All rights reserved.
//
//

#import "PersonEntity+CoreDataProperties.h"

@implementation PersonEntity (CoreDataProperties)

+ (NSFetchRequest<PersonEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonEntity"];
}

@dynamic id;
@dynamic name;
@dynamic infoEntity;
@dynamic moreEntity;

@end
