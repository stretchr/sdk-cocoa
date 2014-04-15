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

/**
 *  Instructs Stretchr to sort the response, in ascending order, by the
 *  value contained at the given key.
 *
 *  This method allows you to specify multiple keys for sorting. Each time you
 *  call this method, the key will be added to the list of keys on which to
 *  sort.
 *  The response will be sorted first by the first item, then by the next, etc.
 *
 *  @param key The key to use when sorting.
 */
- (void)addOrderByKeyAscending:(NSString*)key;

/**
 *  Instructs Stretchr to sort the response, in descending order, by the
 *  value contained at the given key.
 *
 *  This method allows you to specify multiple keys for sorting. Each time you
 *  call this method, the key will be added to the list of keys on which to
 *  sort.
 *  The response will be sorted first by the first item, then by the next, etc.
 *
 *  @param key The key to use when sorting.
 */
- (void)addOrderByKeyDescending:(NSString*)key;

/**
 *  Instructs Stretchr to limit the number of resources returned to the given
 *  value. Currently, the default limit is 100 and the maximum is 1000.
 */
@property(readwrite, assign, nonatomic) NSUInteger limit;

/**
 *  Instructs Stretchr to skip the number of resources given by this value.
 *  This can be used for paging. It is recommended to use the setPage:
 *  function instead.
 */
@property(readwrite, assign, nonatomic) NSUInteger skip;

/**
 *  Calculates the appropriate skip parameter to set in order to retrieve the
 *  desired page based on the current limit value.
 *
 *  @param page The page to retrieve.
 */
- (void)setPage:(NSUInteger)page;

// @Aggregation

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Returns the sum of the values contained at each of the given keys.
 *
 *  @param keys The keys on which to perform the sum aggregation.
 */
- (void)setAggregateSumForKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Returns the maximum of the values contained at each of the given keys.
 *
 *  @param keys The keys on which to perform the max aggregation.
 */
- (void)setAggregateMaxForKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Returns the minimum of the values contained at each of the given keys.
 *
 *  @param keys The keys on which to perform the min aggregation.
 */
- (void)setAggregateMinForKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Returns the average of the values contained at each of the given keys.
 *
 *  @param keys The keys on which to perform the average aggregation.
 */
- (void)setAggregateAverageForKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  For each key, returns an array of all the unique values contained
 *  at that key throughout the dataset.
 *
 *  @param keys The keys on which to perform the uniqueSet aggregation.
 */
- (void)setAggregateUniqueSetForKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Groups each result resource by the given keys. Similar to an SQL
 *  SELECT one,two statement.
 *
 *  @param keys The keys on which to perform the group aggregation.
 */
- (void)setAggregateGroupByKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  If the value contained at the given key is an array type, it will be
 *  exploded into one resource per value, allowing the aggregation
 *  functions to operate on the data contained therein.
 *
 *  @param keys The keys on which to unwind.
 */
- (void)setAggregateUnwindKeys:(NSArray*)keys;

/**
 *  Instructs Stretchr to perform an aggregation operation on the given
 *  keys.
 *
 *  Returns the count of the number of records matching the complete
 *  aggregation query.
 */
- (void)setAggregateCountResults;

// @General

/**
 *  Adds a raw key and value parameter to the query. Useful if you simply wish
 *  to type your query parameters using the Stretchr URL syntax directly.
 *
 *  @param key   The key for the query parameter.
 *  @param value The value for the query parameter.
 */
- (void)addParameterForKey:(NSString*)key value:(NSString*)value;

@end
