//
//  CampaignList.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Campaign.h"


@interface CampaignList : NSObject {
	NSMutableArray *campaigns;
	Campaign *_currentCampaignObject;
	NSMutableString *_contentOfCurrentCampaignProperty;
}
	
@property (nonatomic, retain) Campaign *currentCampaignObject;
@property (nonatomic, retain) NSMutableString *contentOfCurrentCampaignProperty;
	
-(Campaign *)campaignAtIndex:(NSUInteger)index;
-(NSUInteger)count;
-(void)refreshCampaignList;
-(void)getCampaignsFromWeb;

@end
