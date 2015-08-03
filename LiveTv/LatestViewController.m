//
//  LatestViewController.m
//  LiveTv
//
//  Created by Istvan Szabo on 2012.05.22..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LatestViewController.h"
#import "Reachability.h"
#import "CLTickerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"
#import "Twitter/Twitter.h"


//#define URL_DATA @"https://dl.dropbox.com/u/71008334/LiveTV/ChannelsList.plist"

@interface LatestViewController ()

@end

@implementation LatestViewController

@synthesize liveTvPlist;
@synthesize channelsPlist;
@synthesize liveTvLogo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ChannelsList" ofType:@"plist"];
    self.liveTvPlist = [NSDictionary dictionaryWithContentsOfFile:plistPath];//[NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:URL_DATA]];
       
       
//    [liveTvLogo setImageWithURL:[NSURL URLWithString:[liveTvPlist valueForKey:@"LatestChannelLogoUrl"]]
//               placeholderImage:[UIImage imageNamed:@"thumbnail.png"]];
    liveTvLogo.image = [UIImage imageNamed:[liveTvPlist valueForKey:@"LatestChannelLogoUrl"]];
    
    CLTickerView *ticker = [[CLTickerView alloc] initWithFrame:CGRectMake(45, 380, 232, 20)];
    ticker.marqueeStr = [liveTvPlist valueForKey:@"LatestChannelScrollText"];
    ticker.marqueeFont = [UIFont italicSystemFontOfSize:12];
    
    [self.view addSubview:ticker];
    [ticker release];
    
    // show in the status bar that network activity stop
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self setLiveTvPlist:nil];
    [self setChannelsPlist:nil];
    [self setLiveTvLogo:nil];}

- (void)viewWillAppear:(BOOL)animated
{
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    
    /* 
     UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
     UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
     */
    
    
    UIImage *selectedTabImage0 = [UIImage imageNamed:@"tab_bar_selected1.png"];
    UIImage *unselectedTabImage0 = [UIImage imageNamed:@"tab_bar_unselected1.png"];
    
    UIImage *selectedTabImage1 = [UIImage imageNamed:@"tab_bar_selected2.png"];
    UIImage *unselectedTabImage1 = [UIImage imageNamed:@"tab_bar_unselected2.png"];
    
    UIImage *selectedTabImage2 = [UIImage imageNamed:@"tab_bar_selected3.png"];
    UIImage *unselectedTabImage2 = [UIImage imageNamed:@"tab_bar_unselected3.png"];
    
    /*
     UIImage *selectedTabImage3 = [UIImage imageNamed:@"tab_bar_selected4.png"];
     UIImage *unselectedTabImage3 = [UIImage imageNamed:@"tab_bar_unselected4.png"];
     
     UIImage *selectedTabImage4 = [UIImage imageNamed:@"tab_bar_selected5.png"];
     UIImage *unselectedTabImage4 = [UIImage imageNamed:@"tab_bar_unselected5.png"];
     */
    
    
    [item0 setFinishedSelectedImage:selectedTabImage0 withFinishedUnselectedImage:unselectedTabImage0];
    [item1 setFinishedSelectedImage:selectedTabImage1 withFinishedUnselectedImage:unselectedTabImage1];
    [item2 setFinishedSelectedImage:selectedTabImage2 withFinishedUnselectedImage:unselectedTabImage2];
    
    /* 
     [item3 setFinishedSelectedImage:selectedTabImage3 withFinishedUnselectedImage:unselectedTabImage3];
     [item4 setFinishedSelectedImage:selectedTabImage4 withFinishedUnselectedImage:unselectedTabImage4];        
     */     
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You must have an active network connection in order to stream Video" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];    
    } 
    
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (IBAction)playLiveTv:(id)sender {
    [self loadVideoPlayer:[liveTvPlist valueForKey:@"LatestChannelLiveUrl"]];
}

- (void)loadVideoPlayer:(NSString *)string
{
    MPMoviePlayerViewController* theMoviePlayer = [[MPMoviePlayerViewController new] 
                                                   initWithContentURL: [NSURL URLWithString:string]];
    
    [self presentMoviePlayerViewControllerAnimated:theMoviePlayer];
    
    theMoviePlayer.moviePlayer.allowsAirPlay = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) { /* handle the error condition */ }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    if (activationError) { /* handle the error condition */ }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tweetButtonPressed:(id)sender {
    
    // Copy and paste code your app----
    
    TWTweetComposeViewController *twitter = [TWTweetComposeViewController new];
    
    // Customize: set an image, url and initial text
    [twitter addImage:[UIImage imageNamed:@"thumbnail.png"]];
    [twitter addURL:[NSURL URLWithString:@"http://codecanyon.net/user/mactechinteractiv/"]];
    [twitter setInitialText:@"New channel add LiveTv app."];
    
    
    
    [self presentModalViewController:twitter animated:YES];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
    {
        NSString *title = @"Tweet Status";
        NSString *_message; 
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            _message = @"Tweet composition was cancelled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            _message = @"Tweet composition done.";
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        [self dismissModalViewControllerAnimated:YES];
    };
    
    // -----end
    
}
- (void)dealloc {
    [liveTvLogo release];
    [liveTvPlist release];
    [channelsPlist release];
    [super dealloc];
}

@end
