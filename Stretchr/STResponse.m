//
//  STResponse.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResponse.h"
#import "STNSString+STExtensions.h"
#import "STResource.h"
#import "STResourceCollection.h"
#import "STRequest.h"
#import "STChangeInfo.h"
#import "STConstants.h"
#import "STErrors.h"

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
- (NSDictionary*)bodyDictionaryOrError:(NSError*__autoreleasing *)error
{
  if ([NSString isNilOrEmpty:self.body])
    return nil;
  
  return [NSJSONSerialization JSONObjectWithData:[self.body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
    
}
- (STResource*)resourceOrError:(NSError*__autoreleasing *)error
{
  error = nil;
  NSDictionary *responseData = [self bodyDictionaryOrError:error];
  
  if (error != nil) {
    return nil;
  }
  NSDictionary *data = responseData[STResponseConstants.Data];

  STResource* resource = [[STResource alloc] initWithClient:self.request.client forPath:self.request.path];
  [resource.data addEntriesFromDictionary:data];
  return resource;
}
- (STResourceCollection*)resourceCollectionOrError:(NSError*__autoreleasing *)error {
  
  error = nil;
  NSDictionary *responseData = [self bodyDictionaryOrError:error];
  
  if (error != nil) {
    return nil;
  }
  
  // get the data
  NSDictionary *data = responseData[STResponseConstants.Data];
  STResourceCollection *collection = [[STResourceCollection alloc] initWithCapacity:(NSUInteger)data[STResponseConstants.Count]];
  
  // if there is a total - set it
  if (data[STResponseConstants.Total]) {
    collection.total = [(NSNumber*)data[STResponseConstants.Total] intValue];
  }
  
  // get the items
  NSArray *items = (NSArray*)data[STResponseConstants.Items];
  for (NSInteger i = 0; i < items.count; i++) {
    NSDictionary *item = [items objectAtIndex:i];
    STResource* resource = [[STResource alloc] initWithClient:self.request.client forPath:self.request.path];
    [resource.data addEntriesFromDictionary:item];
    [collection.resources addObject:resource];
  }
  
  return collection;
}
- (STChangeInfo*)changeInfoOrError:(NSError*__autoreleasing *)error
{
  NSDictionary *response = [self bodyDictionaryOrError:error];
  if (!STIsError(error)) {
    return [[STChangeInfo alloc] initWithChangeDictionary:response[STResponseConstants.Changes]];
  }
  return nil;
}

@end
