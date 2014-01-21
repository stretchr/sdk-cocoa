#import <Foundation/Foundation.h>

@interface URLConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error;
@end