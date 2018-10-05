//
//  PersonInfoModel.m
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "PersonInfoModel.h"

@implementation PersonInfoModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
@end
