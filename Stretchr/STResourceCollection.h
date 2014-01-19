//
//  STResourceCollection.h
//  Stretchr
//
//  Created by Mat Ryer on 1/19/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STResourceCollection : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;

@property (readwrite, strong) NSMutableArray *resources;
@property (readwrite) NSUInteger total;
@property (readwrite) BOOL hasTotal;

@end
