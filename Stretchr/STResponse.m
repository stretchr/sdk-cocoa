//
//  STResponse.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STResponse.h"

@implementation STResponse

- (BOOL) success {
  return self.status >= 100 && self.status < 400;
}

@end
