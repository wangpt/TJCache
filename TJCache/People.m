//
//  People.m
//  FMDBTestDemo
//
//  Created by 曹小猿 on 16/8/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import "People.h"

@interface People ()<NSCoding>

@end

@implementation People
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.age forKey:@"age"];
  [encoder encodeObject:self.pets forKey:@"pets"];
  [encoder encodeObject:self.car forKey:@"car"];

}
- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
  self.name = [decoder decodeObjectForKey:@"name"];
  self.age = [decoder decodeObjectForKey:@"age"];
  self.pets = [decoder decodeObjectForKey:@"pets"];
  self.car = [decoder decodeObjectForKey:@"car"];
  }

  return self;
}

@end
