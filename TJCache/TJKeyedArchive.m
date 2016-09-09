//
//  TJKeyedArchive.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/8.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJKeyedArchive.h"
#define kNameKey @"NameKey"
#define kAgeKey @"AgeKey"
@implementation TJKeyedArchive
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeInteger:_age forKey:kAgeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _age = [aDecoder decodeIntegerForKey:kAgeKey];
    }
    return self;
}

#define KLocalData_User_Login @"KLocalData_User_login"

+ (BOOL)save{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:KLocalData_User_Login];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)remove{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KLocalData_User_Login];
    
}

+(TJKeyedArchive *)read{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KLocalData_User_Login];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


//创建
+ (BOOL)createPerson{
    
    TJKeyedArchive *person = [[TJKeyedArchive alloc] init];
    person.name = @"Rio";
    person.age = 22;
    //获得Document的路径
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"person.archiver"];//拓展名可以自己随便取
    return [NSKeyedArchiver archiveRootObject:person toFile:path];
    
}

//读取
+(TJKeyedArchive *)readPerson{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"person.archiver"];
    TJKeyedArchive *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return person;
}

//删除
+ (BOOL)deleteAllDatas
{
    // 获取cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 获取文件的全路径
    
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"person.archiver"];
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (exists) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    return exists;
}

@end
