//
//  STCollection.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STCollection;
@class STResponse;
@class STRequest;

/**
 *  STCollectionBlock defines the block signature for the block
 *  that will be called when a collection response is received
 *  from Stretchr
 *
 *  @param request The original STRequest object used to make the request.
 *  @param resource The STCollection object from the response returned by
 *  Stretchr.
 */
typedef void (^STCollectionBlock)(STRequest* request, STCollection* collection);

@interface STCollection : NSObject

/**
 *  An array of STResource objects in this collection object.
 */
@property(readonly, nonatomic, copy) NSArray* resources;

/**
 *  The number of objects in this collection.
 */
@property(readonly, nonatomic) NSUInteger count;

/**
 *  The total number of objects in this collection.
 *
 *  This value will only be set if the "total" parameter was included in the
 *  request that generated this colletion.
 */
@property(readonly, nonatomic) NSUInteger total;

/**
 *  All the objects in the response in raw NSDictionary format. Useful if you
 *  simply want to directly access the objects themselves without having to
 *  unwrap an STResource object.
 */
@property(readonly, nonatomic, copy) NSArray* rawObjects;

/**
 *  Creates a new STCollection object out of the given data object.
 *
 *  @param response The data object from which to build the STCollection object.
 *  This data object is extracted from an STResponse object.
 *
 *  @return The built STCollection object.
 */
+ (id)collectionWithData:(NSDictionary*)data;

/**
 *  Creates a new STCollection object out of the given data object.
 *
 *  @param response The data object from which to build the STCollection object.
 *  This data object is extracted from an STResponse object.
 *
 *  @return The built STCollection object.
 */
- (id)initWithData:(NSDictionary*)data;

@end
