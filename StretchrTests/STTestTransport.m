//
//  STTestTransport.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STTestTransport.h"
#import "STResponse.h"
#import "STRequest.h"
#import "NSMutableArray+Queue.h"

@implementation STTestTransport

- (id)init
{
  if (!(self = [super init]))
    return nil;
  
  _requests = [NSMutableArray array];
  _responses = [NSMutableArray array];
  
  return self;
}

- (STResponse *)makeRequest:(STRequest *)request
{
  [self.requests enqueue:request];
  return [self.responses dequeue];
}

@end
