//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionList.h"
#import "Survey.h"


@interface QuestionListViewController : UITableViewController {
	NSString *_surveyId;
	IBOutlet UINavigationItem *_surveyName;
	QuestionList *questions;
}

@property (nonatomic, retain) NSString *surveyId;
@property (nonatomic, retain) UINavigationItem *surveyName;
@property (nonatomic, retain) QuestionList *questions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)survey;

@end
