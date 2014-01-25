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

- (id)initWithAccount:(NSString*)account project:(NSString*)project APIKey:(NSString*)APIKey
{
  if (!(self = [super init]))
    return nil;
  
  _account = account;
  _project = project;
  _APIKey = APIKey;
  _host = [NSString stringWithFormat:@"%@.%@",account,STDefaults.HostSuffix];
  _protocol = STDefaults.Protocol;
  _transport = [[STWebTransport alloc] init];
  
  return self;
  
}

- (NSString*)baseURLString
{
  return [NSString stringWithFormat:@"%@://%@/api/v%@/%@/",_protocol,_host,STDefaults.Version,_project];
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
