//
//  STClient.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTransportProtocol.h"

@class STRequest;

@interface STClient : NSObject

- (id)initWithProject:(NSString*)project APIKey:(NSString*)APIKey;

- (STRequest*)requestAt:(NSString*)path;

@property(readonly,copy)NSString* project;
@property(readonly,copy)NSString* APIKey;

@property(readwrite,copy)NSString* host;
@property(readwrite,copy)NSString* protocol;
@property(readwrite,strong)id<STTransportProtocol> transport;

@end
