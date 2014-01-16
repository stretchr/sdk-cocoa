//
//  STClient.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STClient.h"
#import "STConstants.h"
#import "STRequest.h"
#import "STWebTransport.h"

@implementation STClient

-(id)initWithProject:(NSString *)project APIKey:(NSString *)APIKey
{
  if (!(self = [super init]))
    return nil;
  
  _project = project;
  _APIKey = APIKey;
  _host = [NSString stringWithFormat:@"%@.%@",project,STDefaults.HostSuffix];
  _protocol = STDefaults.Protocol;
  _transport = [[STWebTransport alloc] init];
  
  return self;
  
}

- (STRequest*)requestAt:(NSString*)path
{
  return [[STRequest alloc] initWithClient:self path:path];
}

@end
