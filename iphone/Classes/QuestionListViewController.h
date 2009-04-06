//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceDelegate.h"

@class Survey;

@interface QuestionListViewController : UITableViewController {
    Survey *survey;

    IBOutlet UINavigationItem *surveyName;
}

@property (nonatomic, retain) Survey *survey;
@property (nonatomic, retain) UINavigationItem *surveyName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)aSurvey;

@end
