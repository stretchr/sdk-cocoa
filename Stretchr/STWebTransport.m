//
//  STWebTransport.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STWebTransport.h"
#import "STRequest.h"
#import "NSString+STExtensions.h"
#import "STResponse.h"
#import "NSData+STExtensions.h"

@implementation STWebTransport

- (STResponse *)makeRequest:(STRequest *)request orError:(NSError *__autoreleasing *)error
{
  
  NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.URLString]];
  [urlRequest setHTTPMethod:request.HTTPMethod];
  [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
  if (![NSString isNilOrEmpty:request.body])
    [urlRequest setHTTPBody:[request.body dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSHTTPURLResponse* urlResponse = nil;
  NSData* responseBody = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:error];
  
  if (error != nil && *error != nil)
  {
    // A transport level error occurred
    return nil;
  }
  
  STResponse* response = [[STResponse alloc] initWithRequest:request];
  [response setBody:[responseBody UTF8String]];
  
  //TODO: @matryer discuss setting errors and whatnot here
  
  
  return nil;
}

@end
