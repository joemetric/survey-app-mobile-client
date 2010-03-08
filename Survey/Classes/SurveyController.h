//
//  SurveyController.h
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey, QuestionController;

@interface SurveyController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	Survey				*survey;
	QuestionController	*questionController;
	UITableView			*questionsTable;
}

@property (nonatomic, retain) Survey *survey;
@property (nonatomic, retain) IBOutlet UITableView *questionsTable;
@property (nonatomic, retain) QuestionController *questionController;

- (IBAction)takeSurvey;

@end