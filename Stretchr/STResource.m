//
//  STResource.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResource.h"
#import "STClient.h"

@implementation STResource
- (id)initWithClient:(STClient*)client forPath:(NSString*)path
{
  if (!(self = [super init]))
    return nil;
  
  _path = path;
  _client = client;
  _data = [NSMutableDictionary dictionary];
  
  return self;
}
@end
