//
//  NSString+STExtensions.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (STExtensions)
+ (BOOL)isNilOrEmpty:(NSString*)string;
- (BOOL)beginsWithString:(NSString*)string;
- (BOOL)containsString:(NSString*)substring;
@end
