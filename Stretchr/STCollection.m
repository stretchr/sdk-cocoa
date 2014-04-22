//
//  STCollection.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STCollection.h"
#import "STResource.h"
#import "STConstants.h"
#import "STResponse.h"

@implementation STCollection

@synthesize resources = _resources;
@synthesize count = _count;
@synthesize total = _total;
@synthesize rawObjects = _rawObjects;

+ (id)collectionWithData:(NSDictionary *)data {
  return [[STCollection alloc] initWithData:data];
}

- (id)initWithData:(NSDictionary *)data {
  if (!(self = [super init])) {
    return nil;
  }

  NSDictionary *_data = data[STResponseConstants.Data];
  _rawObjects = [_data[STCollectionConstants.Items] copy];
  _resources = [[NSMutableArray alloc] initWithCapacity:[_rawObjects count]];
  for (NSDictionary *item in _rawObjects) {
    [((NSMutableArray *)_resources)
        addObject:[STResource resourceWithData:item]];
  }
  _count = [_data[STCollectionConstants.Count] integerValue];
  _total = [_data[STCollectionConstants.Total] integerValue];

  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Count: %ld, Total: %ld, Resources: %@",
                                    (unsigned long)_count,
                                    (unsigned long)_total, _resources];
}

@end
