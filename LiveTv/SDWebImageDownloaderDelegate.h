#import "SDWebImageCompat.h"

@class SDWebImageDownloader;

@protocol SDWebImageDownloaderDelegate <NSObject>

@optional

- (void)imageDownloaderDidFinish:(SDWebImageDownloader *)downloader;
- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image;
- (void)imageDownloader:(SDWebImageDownloader *)downloader didFailWithError:(NSError *)error;

@end
