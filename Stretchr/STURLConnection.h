#import <Foundation/Foundation.h>

@interface STURLConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error;
@end