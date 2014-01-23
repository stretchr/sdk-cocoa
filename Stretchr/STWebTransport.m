//
//  STWebTransport.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STWebTransport.h"
#import "STRequest.h"
#import "STNSString+STExtensions.h"
#import "STResponse.h"
#import "STNSData+STExtensions.h"
#import "STConstants.h"
#import "STURLConnection.h"

@implementation STWebTransport

- (STResponse *)makeRequest:(STRequest *)request orError:(NSError *__autoreleasing *)error
{
  
  NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.URLString]];
  [urlRequest setHTTPMethod:request.HTTPMethod];
  
  [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];

  if (![NSString isNilOrEmpty:request.body]) {
    [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[request.body dataUsingEncoding:NSUTF8StringEncoding]];
  }
  
  NSHTTPURLResponse* urlResponse = nil;
  NSData* responseBody = [STURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:error];
    
  
  if (error != nil && [(*error) code] == kCFURLErrorUserCancelledAuthentication)
  {
    *error = nil;
    error = nil;
  }
  
  if (error != nil && *error != nil)
  {
    // A transport level error occurred
    return nil;
  }
  
  STResponse* response = [[STResponse alloc] initWithRequest:request];
  [response setBody:[responseBody UTF8String]];
  [response setStatus:[urlResponse statusCode]];
    
  return response;
}

@end
