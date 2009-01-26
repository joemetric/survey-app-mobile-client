//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionList.h"
#import "Campaign.h"


@interface QuestionListViewController : UITableViewController {
	NSString *_campaignId;
	IBOutlet UINavigationItem *_campaignName;
	QuestionList *questions;
}

@property (nonatomic, retain) NSString *campaignId;
@property (nonatomic, retain) UINavigationItem *campaignName;
@property (nonatomic, retain) QuestionList *questions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil campaign:(Campaign *)campaign;

@end
