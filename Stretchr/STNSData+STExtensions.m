//
//  NSData+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/20/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STNSData+STExtensions.h"

@implementation NSData (STExtensions)
- (NSString*)UTF8String
{
  return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
@end
