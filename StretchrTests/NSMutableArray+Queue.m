//
//  NSMutableArray+Queue.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)
- (id) dequeue {
  if ([self count] == 0) return nil;
  id headObject = [self objectAtIndex:0];
  if (headObject != nil) {
    [self removeObjectAtIndex:0];
  }
  return headObject;
}
- (void) enqueue:(id)anObject {
  [self addObject:anObject];
}
@end
