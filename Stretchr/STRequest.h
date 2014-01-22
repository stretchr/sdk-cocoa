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
@class STResource;

@interface STRequest : NSObject

- (id)initWithClient:(STClient*)client path:(NSString*)path;

@property (readonly,strong,nonatomic) STClient* client;
@property (readonly,copy,nonatomic) NSString* path;
@property (readonly,strong,nonatomic) NSDictionary* parameters;
@property (readonly,strong,nonatomic) NSDictionary* filters;
@property (readwrite,copy,nonatomic) NSString* body;
@property (readwrite,copy) NSString *HTTPMethod;

- (void)setValue:(NSString*)value forParameter:(NSString*)key;
- (void)setValue:(NSString*)value forFilter:(NSString*)key;

- (NSString*)URLString;

#pragma mark - Data

- (void)setBodyData:(id)data orError:(NSError*__autoreleasing *)error;

#pragma mark - Actions

- (STResponse*)readOrError:(NSError*__autoreleasing *)error;
- (STResponse*)deleteOrError:(NSError*__autoreleasing *)error;
- (STResponse*)createResource:(STResource*)resource orError:(NSError*__autoreleasing *)error;

@end
