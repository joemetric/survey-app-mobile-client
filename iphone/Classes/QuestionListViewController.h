//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionList.h"


@interface QuestionListViewController : UITableViewController {
	NSString *_campaignId;
	QuestionList *questions;
}

@property (nonatomic, retain) NSString *campaignId;
@property (nonatomic, retain) QuestionList *questions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil campaignId:(NSString *)campaignId;

@end
