//
//  FMDBClient.m
//  TJCache
//
//  Created by tao on 2018/10/4.
//  Copyright © 2018年 王朋涛. All rights reserved.
//


#import "FMDBClient.h"
#import "FMDB.h"
#import "PersonModel.h"
// ---------------线程----------------------------------------------
#define kBgQueue    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kMainQueue  dispatch_get_main_queue()
#define EXE_ON_MAIN_THREAD(function)\
dispatch_async(kBgQueue, ^{\
dispatch_sync(kMainQueue, ^{function;});\
});\
// ---------------线程---end-------------------------------------------
#define DBNAME @"FMDBTestDemo.sqlite"
static FMDatabaseQueue *_queue;
static FMDBClient *sharedInstance = nil;
@implementation FMDBClient
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)initialize{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:DBNAME];
    _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    NSLog(@"filePath:%@",fileName);
    [_queue inDatabase:^(FMDatabase *db) {
        //INTEGER，值是有符号整形，根据值的大小以1,2,3,4,6或8字节存放
        // REAL，值是浮点型值，以8字节IEEE浮点数存放
        //TEXT，值是文本字符串，使用数据库编码
        //BLOB，二进制数据
        BOOL b = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS People (id text,info blob)"];
        NSLog(@"create table is %d",b);

    }];
    
}

/**
 *  执行一个更新语句
 *
 *  @param sql 更新语句的sql
 *
 *  @return 更新语句的执行结果
 */
+ (BOOL)executeUpdate:(NSString *)sql{
    
    __block BOOL updateRes = NO;
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        updateRes = [db executeUpdate:sql];
    }];
    
    return updateRes;
}


/**
 *  执行一个查询语句
 *
 *  @param sql              查询语句sql
 *  @param queryResBlock    查询语句的执行结果
 */
+ (void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock{
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:sql];
        
        if(queryResBlock != nil) queryResBlock(set);
        
    }];
}

/**
 后期版本新加字端
 */
+ (void)columnExists{
    [_queue inDatabase:^(FMDatabase *db) {
        if (![db columnExists:@"mesType" inTableWithName:@"People"]){
            NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",@"People",@"mesType"];
            BOOL worked = [db executeUpdate:alertStr];
            if(worked){
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
        }
    }];
}
#pragma mark - 新增数据
/**
 保存（新增或更新）用户信息
 @param catalogueCode 消息类型
 @param msgTitle 最新的消息
 @param msgContent 详情消息
 */
+ (void)qunueInsertPeople:(PersonModel *)people{
    NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:people.infoModel];
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL insert = [db executeUpdate:@"INSERT INTO People (id, info) VALUES (?,?)",people.id,infoData];
        if (insert) {
            NSLog(@"添加成员成功！！");
        }else{
            NSLog(@"添加成员失败！！");
        }
    }];
#if DEBUG
    [self queryAll];
#endif
}

#pragma mark - 删除数据
/**
 清除数据
 @return 是否成功
 */
+ (BOOL)qunueDeleteAllData{
    BOOL isSucc = [self executeUpdate:@"DELETE FROM People"];
    return isSucc;
}
+ (BOOL)qunueDeletePeople:(NSString *)userId{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM People WHERE id = %@",userId];
    return [self executeUpdate:sql];
}


#pragma mark - 修改数据
/**
 更新该类型的全部数据
 */
+ (void)qunueUpdatePeople:(PersonModel *)people{
    NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:people.infoModel];
    NSString *sql = @"UPDATE People SET id = ? , info = ? WHERE id = ?";
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL insert = [db executeUpdate:sql,people.id.stringValue,infoData,people.id];
        if (insert) {
            NSLog(@"修改成员成功！！");
        }else{
            NSLog(@"修改成员失败！！");
        }
    }];
    
}

#pragma mark - 查找数据
/**
 列出所有用户信息
 */
+ (void)queryAll{
    NSString *sql = @"SELECT * FROM People";
    [self executeQuery:sql queryResBlock:^(FMResultSet *rs) {
        int i=0;
        while ([rs next]) {
            NSLog(@"%d：-------",i);
            NSLog(@"id：%@",[rs stringForColumn:@"id"]);
            NSLog(@"info：%@",[rs dataForColumn:@"info"]);
            NSLog(@"%d：---end--",i);
            i++;
        }
        [rs close];
    }];
}

+ (NSArray *)qunueGetPeople{
    __block NSMutableArray *dataArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM People"];
    [self executeQuery:sql queryResBlock:^(FMResultSet *rs) {
        while ([rs next]) {
            PersonModel *entity = [[PersonModel alloc]init];;
            NSString *userId = [rs stringForColumn:@"id"];
            entity.id =[NSNumber numberWithInteger:userId.integerValue];
            NSData *infoData = [rs dataForColumn:@"info"];
            PersonInfoModel *infoModel = [NSKeyedUnarchiver unarchiveObjectWithData:infoData];
            entity.infoModel =infoModel;
            [dataArray addObject:entity];
        }
        [rs close];
    }];
    return dataArray;
}

/**
 *  用户是否存在
 *
 *  @param userId 用户ID
 *
 *  @return 是否存在
 */

+ (BOOL)checkPerson:(NSString *)userId{
    NSString *alias=@"count";
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM People where id = '%@'", alias, userId];
    
    __block NSUInteger count=0;
    
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        
        while ([set next]) {
            
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    
    return count > 0;
}


@end
