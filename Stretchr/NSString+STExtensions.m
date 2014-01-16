//
//  NSString+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "NSString+STExtensions.h"

@implementation NSString (STExtensions)
- (BOOL)beginsWithString:(NSString*)string
{
  NSRange range = [self rangeOfString:string];
  BOOL beginsWithString = (range.location == 0);
  return beginsWithString;
}

- (BOOL)containsString:(NSString*)substring
{
  NSRange range = [self rangeOfString:substring];
  BOOL found = (range.location != NSNotFound);
  return found;
}
+ (BOOL)isNilOrEmpty:(NSString*)string
{
  if(string == nil) return YES;
  if([string length] == 0) return YES;
  return NO;
}
@end
