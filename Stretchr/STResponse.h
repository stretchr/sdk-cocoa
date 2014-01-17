//
//  STResponse.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STResponse : NSObject

@property (assign) NSInteger status;
@property (copy) NSString* body;
@property (strong) NSArray *errors;

- (BOOL) success;

@end
