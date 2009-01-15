//
//  CampaignListViewController.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampaignList.h"


@interface CampaignListViewController : UITableViewController {
	CampaignList *campaigns;
}

@property (nonatomic, retain) CampaignList *campaigns;

@end
