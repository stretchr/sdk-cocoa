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
@class STResourceCollection;

@interface STResponse : NSObject

- (id)initWithRequest:(STRequest*)request;

@property(readonly,strong)STRequest* request;
@property (assign) NSInteger status;
@property (copy) NSString* body;
@property (strong) NSArray *errors;

- (BOOL) success;

- (NSDictionary*)bodyDictionaryOrError:(NSError*__autoreleasing *)error;
- (STResource*)resourceOrError:(NSError*__autoreleasing *)error;
- (STResourceCollection*)resourceCollectionOrError:(NSError*__autoreleasing *)error;
- (STChangeInfo*)changeInfoOrError:(NSError*__autoreleasing *)error;

@end
