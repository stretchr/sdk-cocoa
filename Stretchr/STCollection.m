//
//  STCollection.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STCollection.h"

@implementation STCollection

+ (id)collectionWithResponse:(STResponse *)response {
  return [[STCollection alloc] initWithResponse:response];
}

- (id)initWithResponse:(STResponse *)response {
  return nil;
}

@end
