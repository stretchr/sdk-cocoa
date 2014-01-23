//
//  NSError+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STNSError+STExtensions.h"

@implementation NSError (STExtensions)
+ (id)errorWithDomain:(NSString *)domain code:(NSInteger)code errorString:(NSString*)errorString errorData:(NSError*)error
{
  //NSDictionary* userInfo = [NSDictionary dictionaryWithObject:errorString forKey:NSLocalizedDescriptionKey];
  id data = error;
  if (data == nil)
  {
    data = [NSNull null];
  }
  return [NSError errorWithDomain:domain code:code userInfo:@{
                                                              NSLocalizedDescriptionKey:errorString,
                                                              @"errorData":data
                                                              }];
}
@end
