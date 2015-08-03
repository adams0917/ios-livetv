//
//  ChannelsViewController.h
//  LiveTv
//
//  Created by Istvan Szabo on 2012.05.22..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCell.h"

@interface ChannelsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *channelsPlist;
@property (nonatomic, strong) NSDictionary *liveTvPlist;

- (IBAction)refresh_:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *channelTable;
- (void)loadVideoPlayer:(NSString *)string;

@end
