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
#import "STRequest.h"
#import "STCollection.h"
#import "STNSString+STExtensions.h"
#import "STNSDictionary+STExtensions.h"
#import "STQuery.h"
#import "STResource.h"
#import "STCollection.h"

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
@interface Stretchr : NSObject

/**
 *  The protocol to use when communicating with Stretchr. Defaults to https.
 */
@property(nonatomic, readwrite, copy) NSString* protocol;

/**
 *  The host at which Stretchr is running. Defaults to stretchr.com.
 */
@property(nonatomic, readwrite, copy) NSString* host;

/**
 *  The account string must be set to the account with which you wish to
 *  interact. This account can be found in your control panel.
 */
@property(nonatomic, readwrite, copy) NSString* account;

/**
 *  The project string must be set to the project with which you wish to
 *  interact. This project can be found in your control panel.
 */
@property(nonatomic, readwrite, copy) NSString* project;

/**
 *  The key string must be set to the key you wish to use for the given
 *  account and project. This key can be found in your control panel.
 */
@property(nonatomic, readwrite, copy) NSString* key;

/**
 *  Creates and configures the shared singleton SDK instance using the given
 *  parameters. This method must be called before calling sharedSDK to retrive
 *  a pointer to the shared instance.
 *
 *  This object is guaranteed to be instantiated only once.
 *
 *  The instance is initialized with the default protocol of "https", as well
 *  as the default host of "stretchr.com". If this application requires these
 *  options to be changed, accessors are provided. The host will typically only
 *  change for private cloud or enterprise installations as they will not be
 *  hosted on "stretchr.com".
 *
 *  The cloud offering of Stretchr enforces the "https" protocol. You should not
 *  change the protocol to "http" if you are using the "stretchr.com" host.
 *
 *  @param account The name of the account you wish to use.
 *  @param project The name of the project you wish to use.
 *  @param key     The key you wish to use.
 */
+ (void)initializeSharedSDKWithAccount:(NSString*)account
                               project:(NSString*)project
                                   key:(NSString*)key;

/**
 *  sharedSDK returns the singleton instance of the Stretchr SDK
 *  object. You must call the initialization function before calling this method
 *  or you will receive a nil object.
 *
 *  @return the shared Stretchr SDK object.
 */
+ (id)sharedSDK;

/**
 *  Creates and configures an instance of the Stretchr object.
 *
 *  Most applications use only one account, project and key, and will
 *  typically use the shared instance for convenience. This method is provided
 *  for those atypical cases where more than one account, project or key is
 *  needed for the application. This method does not interact with the shared
 *  instance in any way.
 *
 *  The instance is initialized with the default protocol of "https", as well
 *  as the default host of "stretchr.com". If this application requires these
 *  options to be changed, accessors are provided. The host will typically only
 *  change for private cloud or enterprise installations as they will not be
 *  hosted on "stretchr.com".
 *
 *  The cloud offering of Stretchr enforces the "https" protocol. You should not
 *  change the protocol to "http" if you are using the "stretchr.com" host.
 *
 *  @param account The name of the account you wish to use.
 *  @param project The name of the project you wish to use.
 *  @param key     The key you wish to use.
 *
 *  @return The initialized Stretchr object.
 */
- (id)initWithAccount:(NSString*)account
              project:(NSString*)project
                  key:(NSString*)key;

// @Resource Operations

/**
 *  Issues a POST to Stretchr, creating the given object at the
 *  given path. The path may contain an explicit ID to use for this object. If
 *  no ID is provided, it will be generated.
 *
 *  @param path     The path at which this resource will be created.
 *  @param object   The resource to be serialized and created.
 *  @param query    The query to include with the request or nil.
 *  @param success  Called when the creation succeeds.
 *  @param failure  Called when the creation fails.
 */
- (void)createResourceAtPath:(NSString*)path
                  withObject:(id)object
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure;

/**
 *  Issues a GET to Stretchr, requesting the data contained
 *  at the given path. The path to read must include an ID. It must not be
 *  a collection path.
 *
 *  @param path    The path, including ID, of the resource to read.
 *  @param query   The query to include with the request or nil.
 *  @param success Called when the read is successful. Contains the resource.
 *  @param failure Called when the read fails.
 */
- (void)readResourceAtPath:(NSString*)path
                     query:(STQuery*)query
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure;

/**
 *  Issues a PATCH to Stretchr, updating the object found
 *  at the given path. The path MUST contain an ID. If no object is found at
 *  that location, this operation is an error.
 *
 *  @param path     The path to the resource.
 *  @param object   The object to use when patching the resource.
 *  @param query    The query to include with the request or nil.
 *  @param success  Called when the update succeeds.
 *  @param failure  Called when the update fails.
 */
- (void)updateResourceAtPath:(NSString*)path
                  withObject:(id)object
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure;

/**
 *  Issues a PUT to Stretchr, replacing the object found
 *  at the given path. The path MUST contain an ID. If no object is found at
 *  that location, the object will be created.
 *
 *  @param path     The path to the resource.
 *  @param object   The object to use when patching the resource.
 *  @param query    The query to include with the request or nil.
 *  @param success  Called when the update succeeds.
 *  @param failure  Called when the update fails.
 */
- (void)replaceResourceAtPath:(NSString*)path
                   withObject:(id)object
                        query:(STQuery*)query
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure;

/**
 *  Issues a DELETE to Stretchr, deleting the object found at the given path.
 *
 *  @param path    The path to the resource.
 *  @param query   The query to include with the request or nil.
 *  @param success Called when the delete succeeds.
 *  @param failure Called when the delete fails.
 */
- (void)deleteResourceAtPath:(NSString*)path
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure;

// @Collection Operations

/**
 *  Issues a POST to Stretchr, creating the given objects at the
 *  given path. The path may not contain an explicit ID.
 *
 *  @param path     The path at which the resources will be created.
 *  @param objects  The resources to be serialized and created.
 *  @param query    The query to include with the request or nil.
 *  @param success  Called when the creation succeeds.
 *  @param failure  Called when the creation fails.
 */
- (void)createCollectionAtPath:(NSString*)path
                   withObjects:(NSArray*)objects
                         query:(STQuery*)query
                       success:(STResponseBlock)success
                       failure:(STFailureBlock)failure;

/**
 *  Issues a GET to Stretchr, requesting the data contained at the given path.
 *  The path to read must not include an ID. It must be a collection path.
 *
 *  @param path    The path to the collection to be read.
 *  @param query   The query to include with the request or nil.
 *  @param success Called when the read is successful. Contains the collection.
 *  @param failure Called when the read fails.
 */
- (void)readCollectionAtPath:(NSString*)path
                       query:(STQuery*)query
                     success:(STCollectionBlock)success
                     failure:(STFailureBlock)failure;

/**
 *  Issues a DELETE to Stretchr, deleting the objects found at the given path.
 *
 *  @param path    The path to the collection.
 *  @param query   The query to include with the request or nil.
 *  @param success Called when the delete succeeds.
 *  @param failure Called when the delete fails.
 */
- (void)deleteCollectionAtPath:(NSString*)path
                         query:(STQuery*)query
                       success:(STResponseBlock)success
                       failure:(STFailureBlock)failure;

// @General

/**
 *  Executes a fully built STRequest object. Useful if you wish to construct
 *your
 *  STRequest manually and submit it for execution.
 *
 *  @param request  The fully constructed STRequest object.
 *  @param query    The query to include with the request or nil.
 *  @param success  Called when the operation succeeds.
 *  @param failure  Called when the operation fails.
 */
- (void)executeRequest:(STRequest*)request
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure;

@end
