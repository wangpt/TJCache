//
//  TJFileManager.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/7.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJFileManager.h"

@implementation TJFileManager

+ (NSUInteger)sizeOfFileAtPath:(NSString *)path{
    NSUInteger size = 0;
    unsigned long long fileSize =[[[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForDocumentsDirectoryWithPath:path] error:nil] fileSize];
    size+=fileSize;
    return size+size;
}
+ (NSUInteger)sizeOfDirectoryAtPath:(NSString *)path {
    NSString *dirPath = [self pathForDocumentsDirectoryWithPath:path];
    NSUInteger size = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}
+(NSString *)sizeFormatted:(NSUInteger)size
{
    
    double convertedValue = size;
    int multiplyFactor = 0;
    
    NSArray *tokens = @[@"bytes", @"KB", @"MB", @"GB", @"TB"];
    
    while(convertedValue > 1024){
        convertedValue /= 1024;
        
        multiplyFactor++;
    }
    
    NSString *sizeFormat = ((multiplyFactor > 1) ? @"%4.2f %@" : @"%4.0f %@");
    
    return [NSString stringWithFormat:sizeFormat, convertedValue, tokens[multiplyFactor]];
}


+(NSString *)pathForDocumentsDirectory
{
    static NSString *path = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        path = [paths lastObject];
    });
    
    return path;
}
+(BOOL)writeFileAtPath:(NSString *)path content:(NSObject *)content
{

    NSString *absolutePath = path;
    BOOL _success =NO;
    if([content isKindOfClass:[NSMutableArray class]])
    {
        _success= [((NSMutableArray *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSArray class]])
    {
        _success=[((NSArray *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSMutableData class]])
    {
        _success=[((NSMutableData *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSData class]])
    {
        _success=[((NSData *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSMutableDictionary class]])
    {
        _success=[((NSMutableDictionary *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSDictionary class]])
    {
        _success=[((NSDictionary *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSJSONSerialization class]])
    {
        _success=[((NSDictionary *)content) writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSMutableString class]])
    {
        _success=[[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:absolutePath atomically:YES];
    }
    else if([content isKindOfClass:[NSString class]])
    {
        _success=[[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:absolutePath atomically:YES];
    }
    else if([content conformsToProtocol:@protocol(NSCoding)])
    {
        _success=[NSKeyedArchiver archiveRootObject:content toFile:absolutePath];
    }
    else {
        [NSException raise:@"Invalid content type" format:@"content of type %@ is not handled.", NSStringFromClass([content class])];
        
        return NO;
    }
    
    return _success;
}

+(NSString *)pathForDocumentsDirectoryWithPath:(NSString *)path
{
    if ([path rangeOfString:[self pathForDocumentsDirectory]].length==0) {
        return [[self pathForDocumentsDirectory] stringByAppendingPathComponent:path];
    }
    return path;

}
//[FCFileManager removeItemAtPath:@"test.txt"];
+(BOOL)removeItemAtPath:(NSString *)path{

    return [[NSFileManager defaultManager] removeItemAtPath:[self pathForDocumentsDirectoryWithPath:path] error:nil];
}


//[TJFileManager createFileAtPath:@"test.txt" withContent:@"File management has never been so easy!!!"];

+ (BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content{
    NSString *pathLastChar = [path substringFromIndex:(path.length - 1)];
    if([pathLastChar isEqualToString:@"/"])
    {
        [NSException raise:@"Invalid path" format:@"file path can't have a trailing '/'."];
        return NO;
    }else{
        if ([self createDirectoriesForPath:[[self pathForDocumentsDirectoryWithPath:path]stringByDeletingLastPathComponent]]) {
            return [TJFileManager writeFileAtPath:[self pathForDocumentsDirectoryWithPath:path] content:content];
            
        }else{
            return NO;
        }
    }
    
    
}
//[TJFileManager existsItemAtPath:@"test.txt"];
+(BOOL)existsItemAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForDocumentsDirectoryWithPath:path]];
}
//[TJFileManager createDirectoriesForPath:@"/a/b/c/d/"];
+(BOOL)createDirectoriesForPath:(NSString *)path
{
    return [[NSFileManager defaultManager] createDirectoryAtPath:[self pathForDocumentsDirectoryWithPath:path] withIntermediateDirectories:YES attributes:nil error:nil];
}
//[TJFileManager readFileAtPath:@"test.txt" withObjectClass:[NSString class]];
+(NSObject *)readFileAtPath:(NSString *)path withObjectClass:(Class)aClass{
    if([aClass isSubclassOfClass:[NSString class]]){
        return [NSString stringWithContentsOfFile:[self pathForDocumentsDirectoryWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    }else if ([aClass isSubclassOfClass:[NSArray class]]){
        
        return [NSArray arrayWithContentsOfFile:[self pathForDocumentsDirectoryWithPath:path]];
        
    }else if ([aClass isSubclassOfClass:[NSDictionary class]]){
        return [NSDictionary dictionaryWithContentsOfFile:[self pathForDocumentsDirectoryWithPath:path]];
    }else if ([aClass isSubclassOfClass:[NSData class]]){
        return [NSData dataWithContentsOfFile:[self pathForDocumentsDirectoryWithPath:path] options:NSDataReadingMapped error:nil];
    }else{
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForDocumentsDirectoryWithPath:path]];
        
    }
}



@end
