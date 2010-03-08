//
//  SettingsController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestRequest.h"
#import "JSON.h"

@class EditSortSurveyController;
@class PercentageToDonateController;
@class User;
@interface SettingsController : UIViewController {
	UITableView		*settingsTable;
	UITableViewCell *newSurveyAlertCell;
	UITableViewCell *locationSpecificSurveyCell;
	UITableViewCell *sortSurveyCell;
	UITableViewCell *locationCell;
	
	//Mine 
	UITableViewCell *additionalCharityContributionCell;
	
	UISwitch		*newSurveyAlertSwitch;
	UISwitch		*locatonSpecificSurveySwitch;
	UILabel			*sortSurveyLabel;
	UILabel			*selectedPercentage; 


	PercentageToDonateController	*percentageToDonateController;
	EditSortSurveyController		*editSortSurveyController;
	BOOL sliderBottonOn;
	User *user;

	BOOL get_geographical_location_targeted_surveys;
}

@property (nonatomic, retain) IBOutlet UITableView	*settingsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *newSurveyAlertCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *locationSpecificSurveyCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *sortSurveyCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *locationCell;
@property (nonatomic, retain) IBOutlet 	UITableViewCell *additionalCharityContributionCell;

@property (nonatomic, retain) IBOutlet UISwitch *newSurveyAlertSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *locatonSpecificSurveySwitch;
@property (nonatomic, retain) IBOutlet UILabel *sortSurveyLabel;
@property (nonatomic, retain) IBOutlet 	UILabel	*selectedPercentage; 

@property (nonatomic, retain) EditSortSurveyController *editSortSurveyController;
@property (nonatomic, retain) 	User *user;

@property (nonatomic, retain) PercentageToDonateController *percentageToDonateController;
@property (nonatomic) 	BOOL sliderBottonOn;
@property (nonatomic) 	BOOL get_geographical_location_targeted_surveys;


- (IBAction) goToSortSurveyController:(id)sender;
- (IBAction) goToSelectPercentageSlider:(id)sender;
- (IBAction) locationSpecificSurveyOn:(id)sender; 
- (void) locationSpecificSurveyButtonStatus;

@end
