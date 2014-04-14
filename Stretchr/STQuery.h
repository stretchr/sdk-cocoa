//
//  STQuery.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/14/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The STQuery class allows you to easily construct complex queries
 *  to be sent to Stretchr. Use this class to specify all query options and
 *  filter options you wish to use, then apply it to your STRequest object.
 *
 *  When filtering, it is possible to filter on nested keys using dot syntax.
 *  For example:
 *
 *  <pre><code>
 *  [query addFilterForKey:@"contributors.name" equals:@"Tyler"];
 *  </pre></code>
 *
 *
 *  If the same key is added more than once, it will be replaced.
 */
@interface STQuery : NSObject

/**
 *  Returns an initialized STQuery object.
 *
 *  @return The initialized STQuery object.
 */
+ (id)query;

/**
 *  Compiles the STQuery into a URL Parameter representation for usage
 *  in the request.
 *
 *  @return The compiled URL Parameter representation.
 */
- (NSString*)queryAsURLParameters;

// @Filtering

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value that is equal to the given
 *  value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key equals:(NSString*)value;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value that is not equal to the given
 *  value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key notEquals:(NSString*)value;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value that is equal to one of the
 *  given values.
 *
 *  @param key   The key on which to match.
 *  @param values The values on which to filter.
 */
- (void)addFilterForKey:(NSString*)key containsOne:(NSArray*)values;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains an array that contains all the given
 *  values.
 *
 *  This operation is used only for a value which is an array.
 *
 *  @param key   The key on which to match.
 *  @param values The values on which to filter.
 */
- (void)addFilterForKey:(NSString*)key containsAll:(NSArray*)values;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value that is not equal to one of the
 *  given values.
 *
 *  @param key   The key on which to match.
 *  @param values The values on which to filter.
 */
- (void)addFilterForKey:(NSString*)key notContains:(NSArray*)values;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value that is between the given
 *  low and high values.
 *
 *  @param key   The key on which to match.
 *  @param low   The low value on which to filter.
 *  @param high  The high value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key
                between:(NSString*)low
                    and:(NSString*)high;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key exists in the record.
 *
 *  @param key   The key on which to match.
 */
- (void)addFilterForKeyExists:(NSString*)key;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key does not exist in the record.
 *
 *  @param key   The key on which to match.
 */
- (void)addFilterForKeyNotExists:(NSString*)key;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value greater than the given value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key greaterThan:(NSString*)value;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value less than the given value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key lessThan:(NSString*)value;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value greater than or equal to
 *  the given value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key greaterThanOrEqualTo:(NSString*)value;

/**
 *  Adds a filter to the request that instructs Stretchr only to return
 *  results where the given key contains a value less than or equal to
 *  the given value.
 *
 *  @param key   The key on which to match.
 *  @param value The value on which to filter.
 */
- (void)addFilterForKey:(NSString*)key lessThanOrEqualTo:(NSString*)value;

// @Querying

// @General

/**
 *  Adds a raw key and value parameter to the query. Useful if you simply wish
 *  to type your query parameters using the Stretchr URL syntax directly.
 *
 *  @param key   The key for the query parameter.
 *  @param value The value for the query parameter.
 */
- (void)addParameterKey:(NSString*)key value:(NSString*)value;

@end