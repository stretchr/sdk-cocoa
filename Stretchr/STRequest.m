//
//  STRequest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STRequest.h"
#import "STClient.h"
#import "NSString+STExtensions.h"

@implementation STRequest

-(id)initWithClient:(STClient *)client path:(NSString*)path
{
  if (!(self = [super init]))
    return nil;
  
  _client = client;
  _path = path;
  _parameters = [[NSMutableDictionary alloc] init];
  _filters = [[NSMutableDictionary alloc] init];
  
  return self;
}

- (void)setValue:(NSString*)value forParameter:(NSString*)key
{
  self.parameters[key] = value;
}
- (void)setValue:(NSString*)value forFilter:(NSString*)key
{
  if (![key beginsWithString:@":"])
  {
    key = [@":" stringByAppendingString:key];
  }
  self.filters[key] = value;
}

@end
