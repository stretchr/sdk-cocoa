//
//  NSDictionary+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STNSDictionary+STExtensions.h"
#import "STNSString+STExtensions.h"

@implementation NSDictionary (STExtensions)

- (NSString*)stringFromQueryComponents {
  NSMutableArray* result = [NSMutableArray arrayWithCapacity:[self count]];
  for (NSString* key in self) {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
      [result addObject:[NSString stringWithFormat:@"%@=%@", key, object]];
    } else if ([object isKindOfClass:[NSArray class]]) {
      for (NSString* subObject in object) {
        [result addObject:[NSString stringWithFormat:@"%@=%@", key, subObject]];
      }
    }
  }
  return [result componentsJoinedByString:@"&"];
}

+ (NSDictionary*)dictionaryFromJSONString:(NSString*)string
                                    error:(NSError* __autoreleasing*)error {
  return [NSJSONSerialization
      JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                 options:NSJSONReadingMutableContainers
                   error:error];
}

@end
