//
//  STRequest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STRequest.h"
#import "STClient.h"

@implementation STRequest

-(id)initWithClient:(STClient *)client path:(NSString*)path
{
  if (!(self = [super init]))
    return nil;
  
  _client = client;
  _path = path;
  
  return self;
}

@end
