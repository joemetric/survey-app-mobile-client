//
//  CampaignListViewController.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "CampaignListViewController.h"
#import "QuestionListViewController.h"
#import "Campaign.h"
#import "CampaignList.h"

@implementation CampaignListViewController

@synthesize campaigns;

- (void)awakeFromNib {
    self.navigationItem.title = @"Campaigns";
    self.campaigns = [[CampaignList alloc] init];
    
    // add our custom button to show our modal view controller
    UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton addTarget:self action:@selector(refreshCampaigns) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.rightBarButtonItem = modalButton;
    [modalViewButton release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)refreshCampaigns {
    [self.campaigns refreshCampaignList];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.campaigns count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Campaign *campaign = [self.campaigns campaignAtIndex:indexPath.row];
    cell.text = [campaign nameAndAmountAsString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    QuestionListViewController *questionListViewController = 
		[[QuestionListViewController alloc] initWithNibName:@"QuestionListView" 
													 bundle:nil 
												   campaign:[self.campaigns campaignAtIndex:indexPath.row]];
    
	[self.navigationController pushViewController:questionListViewController animated:YES];
	NSLog(@"Campaign name: %@", questionListViewController.campaignName);
	NSLog(@"Campaign id: %@", questionListViewController.campaignId);
    [questionListViewController release];    
}

- (void)dealloc {
    [campaigns release];
    [super dealloc];
}


@end

