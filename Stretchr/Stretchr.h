//
//  Stretchr.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STResource.h"
#import "STResponse.h"
#import "STConstants.h"
#import "STTransport.h"

@interface Stretchr : NSObject

/**
 * The Stretchr class is the class through which you will perform all
 * operations.
 * All operations occur asynchronously, with callbacks being called as
 * appropriate.
 * Callbacks are not called on the main thread. You must manually dispatch to
 * the
 * main thread if you wish to perform any operations that require you to be on
 * the main thread.
 */

// @Resource Operations

/**
 *  createResource issues a POST to Stretchr, creating the given object at the
 *  given path. The path may contain an explicit ID to use for this object. If
 *  no ID is provided, it will be generated.
 *
 *  @param object   The resource to be serialized and created.
 *  @param path     The path at which this resource will be created.
 *  @param success  Called when the creation succeeds.
 *  @param failure  Called when the creation fails.
 */
- (void)createResource:(id)object
                atPath:(NSString*)path
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure;

/**
 *  readResourceAtPath issues a GET to Stretchr, requesting the data contained
 *  at the given path. The path to read must include an ID. It must not be
 *  a collection path.
 *
 *  @param path    The path, including ID, of the resource to read.
 *  @param success Called when the read is successful. Contains the resource.
 *  @param failure Called when the read fails.
 */
- (void)readResourceAtPath:(NSString*)path
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure;

/**
 *  updateResourceAtPath issues a PATCH to Stretchr, updating the object found
 *  at the given path. The path MUST contain an ID. If no object is found at
 *that
 *  location, this operation is an error.
 *
 *  @param path     The path to the resource.
 *  @param object   The object to use when patching the resource.
 *  @param success  Called when the update succeeds.
 *  @param failure  Called when the update fails.
 */
- (void)updateResourceAtPath:(NSString*)path
                withResource:(id)object
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure;

/**
 *  replaceResourceAtPath issues a PUT to Stretchr, replacing the object found
 *  at the given path. The path MUST contain an ID. If no object is found at
 *that
 *  location, the object will be created.
 *
 *  @param path     The path to the resource.
 *  @param object   The object to use when patching the resource.
 *  @param success  Called when the update succeeds.
 *  @param failure  Called when the update fails.
 */
- (void)replaceResourceAtPath:(NSString*)path
                 withResource:(id)object
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure;

/**
 *  deleteResourceAtPath issues a DELETE to Stretchr, deleting the object
 *  found at the given path.
 *
 *  @param path    The path to the resource.
 *  @param success Called when the delete succeeds.
 *  @param failure Called when the delete fails.
 */
- (void)deleteResourceAtPath:(NSString*)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure;

// @ResourceCollection Operations

@end
