//
//  NSError+STExtensions.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (STExtensions)
+ (id)errorWithDomain:(NSString *)domain code:(NSInteger)code errorString:(NSString*)errorString errorData:(NSError*)error;
@end
