//
//  STChangeInfo.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STChangeInfo.h"
#import "STConstants.h"


@implementation STChangeInfo
- (id)initWithChangeDictionary:(NSDictionary*)changes
{
  if (!(self = [super init]))
    return nil;
  
  if (changes != nil)
  {
    id temp = nil;
    temp = [changes objectForKey:STChangeInfoConstants.Created];
    _created = temp == nil ? 0 : [temp integerValue];
    temp = [changes objectForKey:STChangeInfoConstants.Updated];
    _updated = temp == nil ? 0 : [temp integerValue];
    temp = [changes objectForKey:STChangeInfoConstants.Deleted];
    _deleted = temp == nil ? 0 : [temp integerValue];
    _deltas = [changes objectForKey:STChangeInfoConstants.Deltas];
  }
  
  return self;
}
@end
