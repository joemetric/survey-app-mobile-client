//
//  BrowseController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveyController, Survey;

@interface BrowseController : UIViewController {
	UILabel *instructionLabel;
	UITableView *surveyTable;
	
	NSMutableArray *surveys;
	SurveyController *surveyController;
}

@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;
@property (nonatomic, retain) IBOutlet UITableView *surveyTable;
@property (nonatomic, retain) NSMutableArray *surveys;
@property (nonatomic, retain) SurveyController *surveyController;

- (void)removeSurvey:(Survey *)survey;

@end
