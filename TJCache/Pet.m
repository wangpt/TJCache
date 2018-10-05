//
//  Pet.m
//  FMDBTestDemo
//
//  Created by 曹小猿 on 16/8/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import "Pet.h"

@interface Pet ()<NSCoding>

@end

@implementation Pet
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.age forKey:@"age"];
  
}
- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
  self.name = [decoder decodeObjectForKey:@"name"];
  self.age = [decoder decodeObjectForKey:@"age"];
  }
  return self;
}

@end
