//
//  NSString+STExtensions.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STNSString+STExtensions.h"
#import "STConstants.h"

@implementation NSString (STExtensions)

+ (BOOL)isNilOrEmpty:(NSString *)string {
  return string == nil || [string length] == 0;
}

- (BOOL)beginsWithString:(NSString *)string {
  return [self rangeOfString:string].location == 0;
}

- (BOOL)containsString:(NSString *)substring {
  return [self rangeOfString:substring].location != NSNotFound;
}

- (NSString *)stringByEncodingURLFormat {
  return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
      NULL, (CFStringRef)self, NULL, (CFStringRef)STEscapeChars,
      kCFStringEncodingUTF8));
}

- (NSString *)cleanPath {

  return [self stringByTrimmingCharactersInSet:
                   [NSCharacterSet characterSetWithCharactersInString:@"/"]];
}

@end
