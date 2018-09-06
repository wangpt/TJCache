//
//  PersonModel.m
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.id = [aDecoder decodeObjectForKey:@"id"];
    self.infoModel = [aDecoder decodeObjectForKey:@"infoModel"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.infoModel forKey:@"infoModel"];
    
}
@end
