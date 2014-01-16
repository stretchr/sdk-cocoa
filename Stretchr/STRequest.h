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

@property(readonly,strong,nonatomic)STClient* client;
@property(readonly,strong,nonatomic)NSString* path;
@property(readonly,strong,nonatomic)NSMutableDictionary* parameters; // TODO: figure out how to make this be immutable
@property(readonly,strong,nonatomic)NSMutableDictionary* filters; // TODO: figure out how to make this be immutable

- (void)setValue:(NSString*)value forParameter:(NSString*)key;
- (void)setValue:(NSString*)value forFilter:(NSString*)key;

@end
