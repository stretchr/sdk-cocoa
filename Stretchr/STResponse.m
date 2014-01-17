//
//  STResponse.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResponse.h"
#import "NSString+STExtensions.h"
#import "STResource.h"
#import "STRequest.h"

@implementation STResponse

- (id)initWithRequest:(STRequest*)request
{
  if (!(self = [super init]))
    return nil;
  
  _request = request;
  
  return self;
}

- (BOOL) success
{
  return self.status >= 100 && self.status < 400;
}

// bodyDictionary returns a nil object if it fails to decode the JSON string
- (NSDictionary*)bodyDictionaryOrError:(NSError**)error
{
  if ([NSString isNilOrEmpty:self.body])
    return nil;
  
  return [NSJSONSerialization JSONObjectWithData:[self.body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
    
}
- (STResource*)resourceOrError:(NSError**)error
{
  STResource* resource = [[STResource alloc] initWithClient:self.request.client forPath:self.request.path];
  [resource.data addEntriesFromDictionary:[self bodyDictionaryOrError:error]];
  return resource;
}

@end
