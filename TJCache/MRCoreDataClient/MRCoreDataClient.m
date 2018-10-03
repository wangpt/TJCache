//
//  MRCoreDataClient.m
//  TJCache
//
//  Created by tao on 2018/10/3.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "MRCoreDataClient.h"
#import "PersonEntity+CoreDataClass.h"
#import "PersonInfoEntity+CoreDataClass.h"

@implementation MRCoreDataClient

#pragma mark - save
///新增用户
+ (void)savePersonId:(NSString *)id name:(NSString *)name sex:(NSString *)sex{
    PersonEntity *person = [self readPersonId:id];
    if(!person){
        person = [PersonEntity MR_createEntity];
    }
    PersonInfoEntity *personInfo = [PersonInfoEntity MR_createEntity];
    person.infoEntity = personInfo;
    person.name = name;
    person.id = id;
    person.infoEntity.infoSex = sex;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

#pragma mark - remove
+ (void)removeAllObjects{
    [PersonEntity MR_truncateAll];
}

+ (void)removePerson:(NSString *)id{
    NSArray *personArr = [PersonEntity MR_findByAttribute:@"id" withValue:id];
    for (PersonEntity *person in personArr) {
        [person MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

#pragma mark - updata
+ (void)updataPersonId:(NSString *)id name:(NSString *)name sex:(NSString *)sex{
    PersonEntity *updatePerson = [self readPersonId:id];
    PersonInfoEntity *personInfo = [PersonInfoEntity MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    updatePerson.infoEntity = personInfo;
    updatePerson.name =name;
    personInfo.infoSex = sex;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

#pragma mark - read
+ (NSArray *)readAllData{
    return [PersonEntity MR_findAll];
}

+ (NSArray *)readAllDataByAscending:(BOOL)ascending{
    NSArray *persons = [PersonEntity MR_findAllSortedBy:@"id" ascending:ascending];
    return persons;
}

+ (PersonEntity *)readPersonId:(NSString *)id{
    PersonEntity* person = [PersonEntity MR_findFirstByAttribute:@"id" withValue:id];
    return person;
}

+ (PersonEntity *)readFirstPerson{
    return [PersonEntity MR_findFirst];
}

@end
