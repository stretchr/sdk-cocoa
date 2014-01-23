//
//  STErrors.c
//  Stretchr
//
//  Created by Mat Ryer on 1/22/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STErrors.h"
#import <Foundation/Foundation.h>

bool STIsError(NSError*__autoreleasing * error) {
  // returns true if an error is present
  return (error != nil && *error != nil);
};
