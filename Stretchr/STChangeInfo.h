//
//  STChangeInfo.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STChangeInfo : NSObject
- (id)initWithChangeDictionary:(NSDictionary*)response;
@property(readonly)NSUInteger created;
@property(readonly)NSUInteger updated;
@property(readonly)NSUInteger deleted;
@property(readonly,strong)NSArray* deltas;
@end
