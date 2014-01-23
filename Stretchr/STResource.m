//
//  STResource.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "STResource.h"
#import "STClient.h"
#import "STRequest.h"
#import "STResponse.h"
#import "STChangeInfo.h"
#import "STConstants.h"

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

#pragma mark - Data

- (BOOL) hasId {
  return self.data[STResourceKeyID] != nil;
}

- (void)setDataFromObject:(id)data
{
  if ([data respondsToSelector:@selector(toDictionary)])
  {
    _data = [[data toDictionary] mutableCopy];
  }
}

#pragma mark - Actions

- (STResponse *)saveOrError:(NSError*__autoreleasing *)error {
  
  STRequest *request;
  
  // is this a POST (create) or a PUT (update)?
  if (![self hasId]) {
    // create
    request = [self.client requestAt:self.path];
  } else {
    // update
    request = [self.client requestAt:[NSString stringWithFormat:@"%@/%@", self.path, self.data[STResourceKeyID]]];
  }
  
  // set the body
  [request setBodyData:self.data orError:error];
  
  if (!STIsError(error)) {
    
    STResponse *response;
    
    // is this a POST (create) or a PUT (update)?
    if (![self hasId]) {
      // create
      response = [request createResource:self orError:error];
    } else {
      // replace
      response = [request replaceResource:self orError:error];
    }
    
    if (!STIsError(error)) {
    
      return response;
      
    }

  }

  return nil;
  
}

@end
