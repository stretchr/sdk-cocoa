//
//  STTransport.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STTransport.h"
#import "STResponse.h"
#import "STRequest.h"
#import "STNSString+STExtensions.h"
#import "STURLConnection.h"

@implementation STTransport

+ (STResponse*)executeRequest:(STRequest*)request error:(NSError**)error {

  NSString* body;

  if (request.object != nil) {
    if ([request.object isKindOfClass:[NSArray class]] ||
        [request.object isKindOfClass:[NSDictionary class]]) {
      NSData* bodyData = [NSJSONSerialization dataWithJSONObject:request.object
                                                         options:0
                                                           error:error];
      if (error != nil && *error != nil) {
        return nil;
      }

      body = [[NSString alloc] initWithData:bodyData
                                   encoding:NSUTF8StringEncoding];
    }
  }

  NSMutableURLRequest* urlRequest = [NSMutableURLRequest
      requestWithURL:[NSURL URLWithString:request.URLString]];
  [urlRequest setHTTPMethod:request.method];

  [urlRequest setValue:@"application/json; charset=utf-8"
      forHTTPHeaderField:@"Accept"];

  if (![NSString isNilOrEmpty:body]) {
    [urlRequest setValue:@"application/json; charset=utf-8"
        forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
  }

  NSHTTPURLResponse* urlResponse = nil;
  NSData* responseBody = [STURLConnection sendSynchronousRequest:urlRequest
                                               returningResponse:&urlResponse
                                                           error:error];
  if (error != nil && [(*error)code] ==
                          kCFURLErrorUserCancelledAuthentication) {
    *error = nil;
    error = nil;
  }

  if (error != nil && *error != nil) {
    // A transport level error occurred
    return nil;
  }

  STResponse* response =
      [STResponse responseWithURLResponse:urlResponse body:responseBody];

  return response;
}

@end
