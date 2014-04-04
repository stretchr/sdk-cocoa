//
//  Stretchr.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "Stretchr.h"

@implementation Stretchr

- (void)createResource:(id)resource
                atPath:(NSString *)path
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure {
}

- (void)readResourceAtPath:(NSString *)path
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure {
}

- (void)updateResourceAtPath:(NSString *)path
                withResource:(id)resource
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
}

- (void)replaceResourceAtPath:(NSString *)path
                 withResource:(id)object
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure {
}

- (void)deleteResourceAtPath:(NSString *)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
}

@end
