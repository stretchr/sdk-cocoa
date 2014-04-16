//
//  STResponse.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResponse.h"
#import "STConstants.h"

@implementation STResponse

@synthesize data = _data;
@synthesize errors = _errors;
@synthesize status = _status;

+ (id)responseWithURLResponse:(NSHTTPURLResponse*)response
                         body:(NSData*)body
                        error:(NSError* __autoreleasing*)error {

  return
      [[STResponse alloc] initWithURLResponse:response body:body error:error];
}

- (id)initWithURLResponse:(NSHTTPURLResponse*)response
                     body:(NSData*)body
                    error:(NSError* __autoreleasing*)error {

  if (!(self = [super init])) {

    _data = [NSJSONSerialization JSONObjectWithData:body options:0 error:error];
    if (error != nil && *error != nil) {
      return nil;
    }

    _status = [_data[STResponseConstants.Status] integerValue];
    _errors = _data[STResponseConstants.Errors];
  }
  return self;
}

- (BOOL)success {
  return _status >= 100 && _status < 400;
}

@end
