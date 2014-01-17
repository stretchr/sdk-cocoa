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

@property(readonly,copy,nonatomic)NSString* project;
@property(readonly,copy,nonatomic)NSString* APIKey;

@property(readwrite,copy,nonatomic)NSString* host;
@property(readwrite,copy,nonatomic)NSString* protocol;
@property(readwrite,strong,nonatomic)id<STTransportProtocol> transport;

- (STRequest*)requestAt:(NSString*)path;
- (NSString*)baseURLString;

@end
