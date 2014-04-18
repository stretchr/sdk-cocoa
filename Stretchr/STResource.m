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

+ (id)resourceWithData:(NSDictionary *)data {
  return [[STResource alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data {
  if (!(self = [super init])) {
    return nil;
  }

  _data = [data copy];
  _ID = _data[STResourceConstants.ID];
  _path = _data[STResourceConstants.Path];

  return self;
}

- (NSString *)description {
  return [NSString
      stringWithFormat:@"ID: %@, Path: %@, Data: %@", _ID, _path, _data];
}

@end
