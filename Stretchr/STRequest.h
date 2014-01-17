//
//  STRequest.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STClient;
@class STResponse;

@interface STRequest : NSObject

- (id)initWithClient:(STClient*)client path:(NSString*)path;

@property(readonly,strong,nonatomic)STClient* client;
@property(readonly,copy,nonatomic)NSString* path;
@property(readonly,strong,nonatomic)NSDictionary* parameters;
@property(readonly,strong,nonatomic)NSDictionary* filters;
@property(readonly,copy,nonatomic)NSString* body;

- (void)setValue:(NSString*)value forParameter:(NSString*)key;
- (void)setValue:(NSString*)value forFilter:(NSString*)key;

- (NSString*)URLString;

#pragma mark - Actions

- (STResponse*)read;

@end
