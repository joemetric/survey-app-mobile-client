//
//  SurveyController.h
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey;

@interface SurveyController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *questionsTable;
	
	Survey *survey;
}

@property (nonatomic, retain) IBOutlet UITableView *questionsTable;
@property (nonatomic, retain) Survey *survey;

- (IBAction)takeSurvey;

@end
