//
//  STRequest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "STRequest.h"
#import "STClient.h"
#import "NSString+STExtensions.h"
#import "NSDictionary+STExtensions.h"
#import "STConstants.h"
#import "NSError+STExtensions.h"
#import "STResource.h"

@implementation STRequest
{
  NSMutableDictionary* _parameters;
  NSMutableDictionary* _filters;
}

-(id)initWithClient:(STClient *)client path:(NSString*)path
{
  if (!(self = [super init]))
    return nil;
  
  _client = client;
  _path = path;
  _parameters = [[NSMutableDictionary alloc] init];
  _filters = [[NSMutableDictionary alloc] init];
  
  // set the key (which will always be required)
  _parameters[@"key"] = client.APIKey;
  
  return self;
}

- (void)setValue:(NSString*)value forParameter:(NSString*)key
{
  _parameters[key] = value;
}
- (void)setValue:(NSString*)value forFilter:(NSString*)key
{
  if (![key beginsWithString:@":"])
  {
    key = [@":" stringByAppendingString:key];
  }
  _filters[key] = value;
}

- (NSString*)URLString
{
  NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[self parameters]];
  [dict addEntriesFromDictionary:[self filters]];
  return [NSString stringWithFormat:@"%@%@?%@",[[self client] baseURLString], [self path], [dict stringFromQueryComponents]];
}

#pragma mark - Data

- (void)setBodyData:(id)data orError:(NSError*__autoreleasing *)error {
  
  if (data != nil)
  {
    NSData* body;
    
    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]])
    {
      body = [NSJSONSerialization dataWithJSONObject:data options:0 error:error];
    }
    
    if (error == nil)
    {
      _body = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
      return;      
    }
  }
  
  if (error != nil)
  {
    *error = [NSError errorWithDomain:STErrorDomain
                                 code:STErrorCodes.ObjectNotSerializable
                          errorString:STErrorStrings.ObjectNotSerializable
                            errorData:*error];
  }
}

#pragma mark - Actions

- (STResponse*)readOrError:(NSError*__autoreleasing *)error
{
  self.HTTPMethod = STHTTPMethods.Get;
  return [self.client.transport makeRequest:self orError:error];
}

- (STResponse*)deleteOrError:(NSError*__autoreleasing *)error
{
  self.HTTPMethod = STHTTPMethods.Delete;
  return [self.client.transport makeRequest:self orError:error];
}
- (STResponse*)pushResource:(STResource*)resource withHTTPMethod:(NSString*)HTTPMethod orError:(NSError*__autoreleasing *)error {
  self.HTTPMethod = HTTPMethod;
  [self setBodyData:resource.data orError:error];
  if (NSIsError(error)) {
    return nil;
  }
  return [self.client.transport makeRequest:self orError:error];
}
- (STResponse*)createResource:(STResource*)resource orError:(NSError*__autoreleasing *)error {
  return [self pushResource:resource withHTTPMethod:STHTTPMethods.Post orError:error];
}
- (STResponse*)updateResource:(STResource*)resource orError:(NSError*__autoreleasing *)error {
  return [self pushResource:resource withHTTPMethod:STHTTPMethods.Patch orError:error];
}
- (STResponse*)replaceResource:(STResource*)resource orError:(NSError*__autoreleasing *)error {
  return [self pushResource:resource withHTTPMethod:STHTTPMethods.Put orError:error];
}

@end
