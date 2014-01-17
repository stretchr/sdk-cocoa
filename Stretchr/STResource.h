//
//  STResource.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STClient;

@interface STResource : NSObject
- (id)initWithClient:(STClient*)client forPath:(NSString*) path;
@property(readonly,copy)NSString* path;
@property(readonly,strong)STClient* client;
@property(readonly,strong)NSMutableDictionary* data;
@end
