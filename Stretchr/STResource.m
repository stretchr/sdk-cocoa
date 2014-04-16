//
//  STResource.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResource.h"
#import "STResponse.h"
#import "STConstants.h"

@implementation STResource

@synthesize ID = _ID;
@synthesize path = _path;
@synthesize data = _data;

+ (id)resourceWithResponse:(STResponse *)response {
  return [[STResource alloc] initWithResponse:response];
}

- (id)initWithResponse:(STResponse *)response {
  if (!(self = [super init])) {
    return nil;
  }

  _data = response.data[STResponseConstants.Data];
  _ID = _data[STResourceConstants.ID];
  _path = _data[STResourceConstants.Path];

  return self;
}

- (NSString *)description {
  return [NSString
      stringWithFormat:@"ID: %@, Path: %@, Data: %@", _ID, _path, _data];
}

@end
