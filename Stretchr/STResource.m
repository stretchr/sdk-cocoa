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

- (STResponse *)saveOrError:(NSError**)error {
  
  error = nil;
  STRequest *request;
  
  // is this a POST (create) or a PUT (update)?
  if (![self hasId]) {
    // create
    request = [self.client requestAt:self.path];
    request.HTTPMethod = STHTTPMethods.Post;
  } else {
    // update
    request = [self.client requestAt:[NSString stringWithFormat:@"%@/%@", self.path, self.data[STResourceKeyID]]];
    request.HTTPMethod = STHTTPMethods.Put;
  }
  
  // set the body
  [request setBodyData:self.data orError:error];
  
  if (error == nil) {
    
    // make the request
    STResponse *response = [self.client.transport makeRequest:request];

    // was it successful?
    if (response.success) {

      // merge in the change info
      STChangeInfo *changes = [response changeInfoOrError:error];
      if (error == nil) {
        
        // assume only one delta
        NSDictionary *thisDelta = [changes.deltas objectAtIndex:0];
        [self.data addEntriesFromDictionary:thisDelta];
        
      }
      
    }
    return response;

  }

  return nil;
  
}

@end
