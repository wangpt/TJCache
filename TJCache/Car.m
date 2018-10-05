//
//  Car.m
//  FMDBTestDemo
//
//  Created by 曹小猿 on 16/8/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import "Car.h"

@interface Car ()<NSCoding>

@end
@implementation Car
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.age forKey:@"age"];
  
}
- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if (self!=nil) {

  self.name = [decoder decodeObjectForKey:@"name"];
  self.age = [decoder decodeObjectForKey:@"age"];
  }
  
  return self;
}


@end
