//
//  NSDictionary+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "NSDictionary+STExtensions.h"
#import "NSString+STExtensions.h"

@implementation NSDictionary (STExtensions)

- (NSString *)stringFromQueryComponents
{
  NSMutableArray* result = [NSMutableArray arrayWithCapacity:[self count]];
  for (NSString* key in self)
  {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]])
    {
      [result addObject:[NSString stringWithFormat:@"%@=%@", [key stringByEncodingURLFormat], [object stringByEncodingURLFormat]]];
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
      for (NSString* subObject in object) {
        [result addObject:[NSString stringWithFormat:@"%@=%@", [key stringByEncodingURLFormat], [subObject stringByEncodingURLFormat]]];
      }
    }
    
  }
  return [result componentsJoinedByString:@"&"];
}

/*
 @implementation NSDictionary (StretchrQueryComponents)
 - (NSString *)stringFromQueryComponents
 {
 NSMutableArray* result = [NSMutableArray arrayWithCapacity:[self count]];
 NSMutableArray* sortedKeys = [NSMutableArray arrayWithCapacity:[self count]];
 
 for(NSString* key in self)
 {
 [sortedKeys addObject:key];
 }
 [sortedKeys sortUsingComparator:StretchrStringComparator];
 
 for(NSString* key in sortedKeys)
 {
 if([[self objectForKey:key] isKindOfClass:[NSString class]])
 {
 [result addObject:[NSString stringWithFormat:@"%@=%@", key, [self objectForKey:key]]];
 }
 else
 {
 [[self objectForKey:key] sortUsingComparator:StretchrStringComparator];
 for(NSString* value in [self objectForKey:key])
 {
 [result addObject:[NSString stringWithFormat:@"%@=%@", key,value]];
 }
 }
 }
 return [result componentsJoinedByString:@"&"];
 }
 @end*/

@end
