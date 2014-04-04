//
//  STResource.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResource;

/**
 *  STResourceBlock defines the block signature for the block
 *  that will be called when a resource response is received
 *  from Stretchr
 *
 *  @param resource The STResource object from the response returned by Stretchr.
 */
typedef void (^STResourceBlock)(STResource* resource);

/**
 *  STResource contains the resource data encapsulated in a Stretchr
 *  response object. This data is extracted from an STResponse object
 *  and the original STResponse object is contained within this object
 *  for deeper inspection of the response if desired.
 */
@interface STResource : NSObject

@end
