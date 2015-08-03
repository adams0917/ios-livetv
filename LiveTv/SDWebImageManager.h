#import "SDWebImageCompat.h"
#import "SDWebImageDownloaderDelegate.h"
#import "SDWebImageManagerDelegate.h"
#import "SDImageCacheDelegate.h"

@interface SDWebImageManager : NSObject <SDWebImageDownloaderDelegate, SDImageCacheDelegate>
{
    NSMutableArray *delegates;
    NSMutableArray *downloaders;
    NSMutableDictionary *downloaderForURL;
    NSMutableArray *failedURLs;
}

+ (id)sharedManager;
- (UIImage *)imageWithURL:(NSURL *)url;
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegate>)delegate;
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegate>)delegate retryFailed:(BOOL)retryFailed;
- (void)cancelForDelegate:(id<SDWebImageManagerDelegate>)delegate;

@end
