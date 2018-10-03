//
//  PersonInfoEntity+CoreDataProperties.m
//  TJCache
//
//  Created by tao on 2018/10/2.
//  Copyright © 2018年 王朋涛. All rights reserved.
//
//

#import "PersonInfoEntity+CoreDataProperties.h"

@implementation PersonInfoEntity (CoreDataProperties)

+ (NSFetchRequest<PersonInfoEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonInfoEntity"];
}

@dynamic infoSex;
@dynamic person;

@end
