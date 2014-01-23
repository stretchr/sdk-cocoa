//
//  STResourceCollection.m
//  Stretchr
//
//  Created by Mat Ryer on 1/19/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResourceCollection.h"

@implementation STResourceCollection

@synthesize total = _total;

- (id)initWithCapacity:(NSUInteger)capacity {
  
  if (!(self = [super init]))
    return nil;
  
  _resources = [[NSMutableArray alloc] initWithCapacity:capacity];
  
  return self;
  
}

- (NSUInteger)total {
  if (!self.hasTotal) {
    [NSException exceptionWithName:@"STResourceCollectionNoTotal" reason:@"Cannot get total of a STResourceCollection that was not created with one." userInfo:nil];
  }
  return _total;
}

- (void)setTotal:(NSUInteger)total {
  _total = total;
  self.hasTotal = YES;
}

@end
