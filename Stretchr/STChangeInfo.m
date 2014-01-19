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
    temp = [changes objectForKey:STResponseConstants.Created];
    _created = temp == nil ? 0 : [temp integerValue];
    temp = [changes objectForKey:STResponseConstants.Updated];
    _updated = temp == nil ? 0 : [temp integerValue];
    temp = [changes objectForKey:STResponseConstants.Deleted];
    _deleted = temp == nil ? 0 : [temp integerValue];
    _deltas = [changes objectForKey:STResponseConstants.Deltas];
  }
  
  return self;
}
@end
