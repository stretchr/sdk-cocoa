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
#import "STResource.h"

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

- (NSString*)baseURLString
{
  return [NSString stringWithFormat:@"%@://%@/api/v%@/",_protocol,_host,STDefaults.Version];
}

#pragma mark - Stretchr Interaction

- (STRequest*)requestAt:(NSString*)path
{
  return [[STRequest alloc] initWithClient:self path:path];
}

- (STResource*)newResourceWithPath:(NSString*)path
{
  return [[STResource alloc] initWithClient:self forPath:path];
}

@end
