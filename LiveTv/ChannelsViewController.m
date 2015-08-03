//
//  SecondViewController.m
//  LiveTv
//
//  Created by Istvan Szabo on 2012.05.22..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChannelsViewController.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

//#define URL_DATA @"https://dl.dropbox.com/u/71008334/LiveTV/ChannelsList.plist"


@interface ChannelsViewController ()

@end

@implementation ChannelsViewController

@synthesize channelTable;
@synthesize liveTvPlist;
@synthesize channelsPlist;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //self.liveTvPlist = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:URL_DATA]];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ChannelsList" ofType:@"plist"];
    self.liveTvPlist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    self.channelsPlist = [liveTvPlist objectForKey:@"Channels"];
       
    // show in the status bar that network activity stop
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;}

- (void)viewDidUnload
{
    [self setLiveTvPlist:nil];
    [self setChannelsPlist:nil];
    [self setChannelTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You must have an active network connection in order to stream Video" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];    
    } 
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [channelsPlist count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[channelTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    NSDictionary *videoItem = [channelsPlist objectAtIndex:indexPath.row];     
    
    cell.titleLabel.text =[videoItem valueForKey:@"ChannelTitle"];
    
//    [cell.icon setImageWithURL:[NSURL URLWithString:[videoItem valueForKey:@"ImageUrl"]]
//              placeholderImage:[UIImage imageNamed:@"thumbnail.png"]];
    
    cell.icon.image = [UIImage imageNamed:[videoItem valueForKey:@"ImageUrl"]];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *videoItem = [channelsPlist objectAtIndex:indexPath.row];      
    [self loadVideoPlayer:[videoItem valueForKey:@"ChannelLiveUrl"]];         
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);

}
- (void)dealloc {
    [channelTable release];
    [liveTvPlist release];
    [channelTable release];
    [super dealloc];
}


- (IBAction)refresh_:(id)sender {
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelector:@selector(viewDidLoad) withObject:nil];
    [self.channelTable reloadData]; 
    // show in the status bar that network activity stop
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;}

@end
