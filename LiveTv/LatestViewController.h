//
//  LatestViewController.h
//  LiveTv
//
//  Created by Istvan Szabo on 2012.05.22..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LatestViewController : UIViewController

@property (nonatomic, strong) NSArray *channelsPlist;
@property (nonatomic, strong) NSDictionary *liveTvPlist;
@property (nonatomic, strong) IBOutlet UIImageView *liveTvLogo;


- (IBAction)tweetButtonPressed:(id)sender;
- (IBAction)playLiveTv:(id)sender;

- (void)loadVideoPlayer:(NSString *)string;

@end
