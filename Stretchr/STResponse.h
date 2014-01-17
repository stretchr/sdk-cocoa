//
//  STResponse.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResource;
@class STRequest;
@class STChangeInfo;

@interface STResponse : NSObject

- (id)initWithRequest:(STRequest*)request;

@property(readonly,strong)STRequest* request;
@property (assign) NSInteger status;
@property (copy) NSString* body;
@property (strong) NSArray *errors;

- (BOOL) success;

- (NSDictionary*)bodyDictionaryOrError:(NSError**)error;
- (STResource*)resourceOrError:(NSError**)error;
- (STChangeInfo*)changeInfoOrError:(NSError**)error;

@end
