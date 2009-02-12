//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey;

@interface QuestionListViewController : UITableViewController {
    Survey *survey;
    NSArray *questions;

    IBOutlet UINavigationItem *surveyName;
}

@property (nonatomic, retain) Survey *survey;
@property (nonatomic, retain) NSArray *questions;
@property (nonatomic, retain) UINavigationItem *surveyName;

-(void)refreshQuestions;

@end
