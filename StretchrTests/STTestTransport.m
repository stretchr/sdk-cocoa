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

- (STResponse *)makeRequest:(STRequest *)request orError:(NSError*__autoreleasing *)error
{
  [self.requests enqueue:request];
  //error = [self.errors dequeue];   TODO: simulate errors too
  return [self.responses dequeue];
}

@end
