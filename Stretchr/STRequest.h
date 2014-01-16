//
//  STRequest.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STClient;

@interface STRequest : NSObject

- (id)initWithClient:(STClient*)client path:(NSString*)path;

@property(readonly,strong)STClient* client;
@property(readonly, strong)NSString* path;

@end
