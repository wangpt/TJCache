//
//  TJUserDefaults.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/6.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJUserDefaults.h"

@implementation TJUserDefaults

+ (instancetype)sharedInstance
{
    static TJUserDefaults *shard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shard = [[self alloc] init];
    });
    return shard;
}


//保存数据到NSUserDefaults
- (void)saveNSUserDefaults
{
    NSString *myString = @"enuola";
    int myInteger = 100;
    float myFloat = 50.0f;
    double myDouble = 20.0;
    NSDate *myDate = [NSDate date];
    NSArray *myArray = [NSArray arrayWithObjects:@"hello", @"world", nil];
    NSDictionary *myDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"enuo", @"20", nil] forKeys:[NSArray arrayWithObjects:@"name", @"age", nil]];
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setInteger:myInteger forKey:@"myInteger"];
    [userDefaults setFloat:myFloat forKey:@"myFloat"];
    [userDefaults setDouble:myDouble forKey:@"myDouble"];
    
    [userDefaults setObject:myString forKey:@"myString"];
    [userDefaults setObject:myDate forKey:@"myDate"];
    [userDefaults setObject:myArray forKey:@"myArray"];
    [userDefaults setObject:myDictionary forKey:@"myDictionary"];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}


//从NSUserDefaults中读取数据
- (void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //读取数据到各个label中
    //读取整型int类型的数据
    NSInteger myInteger = [userDefaultes integerForKey:@"myInteger"];
    NSLog(@"txtInteger:%@",[NSString stringWithFormat:@"%ld",(long)myInteger]);
    //读取浮点型float类型的数据
    float myFloat = [userDefaultes floatForKey:@"myFloat"];
    NSLog(@"txtFloat:%@",[NSString stringWithFormat:@"%f",myFloat]);

    //读取double类型的数据
    double myDouble = [userDefaultes doubleForKey:@"myDouble"];
    NSLog(@"txtDouble:%@",[NSString stringWithFormat:@"%f",myDouble]);

    //读取NSString类型的数据
    NSString *myString = [userDefaultes stringForKey:@"myString"];
    NSLog(@"txtNSString:%@",[NSString stringWithFormat:@"%@",myString]);

    //读取NSDate日期类型的数据
    NSDate *myDate = [userDefaultes valueForKey:@"myDate"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"txtNSDate:%@",[NSString stringWithFormat:@"%@",[df stringFromDate:myDate]]);

    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    NSString *myArrayString = [[NSString alloc] init];
    for(NSString *str in myArray)
    {
        NSLog(@"str= %@",str);
        myArrayString = [NSString stringWithFormat:@"%@  %@", myArrayString, str];
        [myArrayString stringByAppendingString:str];
        //        [myArrayString stringByAppendingFormat:@"%@",str];
        NSLog(@"myArrayString=%@",myArrayString);
    }
    NSLog(@"txtNSArray=%@",myArrayString);

    //读取字典类型NSDictionary类型的数据
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"myDictionary"];
    NSString *myDicString = [NSString stringWithFormat:@"name:%@, age:%ld",[myDictionary valueForKey:@"name"], [[myDictionary valueForKey:@"age"] integerValue]];
    NSLog(@"txtNSDictionary=%@",myDicString);
}

@end
