
#import <UIKit/UIKit.h>

@protocol CLScrollviewDelegate <NSObject>

- (void)userTouch;
- (void)userDrag;
- (void)userEndTouch;

@end

@interface CLScrollview : UIScrollView

@property (nonatomic, assign) id <CLScrollviewDelegate> customDelegate;

@end
