#import <Foundation/Foundation.h>

@interface SDNetworkActivityIndicator : NSObject
{
    @private
    NSUInteger counter;
}

+ (id)sharedActivityIndicator;
- (void)startActivity;
- (void)stopActivity;
- (void)stopAllActivity;

@end
