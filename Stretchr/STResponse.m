//
//  STResponse.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResponse.h"

@implementation STResponse

+ (id)responseWithURLResponse:(NSURLResponse*)response body:(NSData*)body {
  return nil;
}

- (BOOL)hasErrors {
  return NO;
}

- (NSArray*)errors {
  return nil;
}

- (int)statusCode {
  return 0;
}

@end
