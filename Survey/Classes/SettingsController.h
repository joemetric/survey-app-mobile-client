//
//  SettingsController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsController : UIViewController {
	UITableView *settingsTable;
	UITableViewCell *newSurveyAlertCell;
	UITableViewCell *locationSpecificSurveyCell;
	UITableViewCell *sortSurveyCell;
	UITableViewCell *fewestQuestionsCell;
	UITableViewCell *locationCell;
	UITableViewCell *sortCell;
	UITableViewCell *newestQuestionsCell;
	UITableViewCell *confirmationCell;
	UIButton *newSurveyAlertButton;
	UIButton *locatonSpecificSurveyButton;
	UILabel *sortSurveyLabel;
}

@property (nonatomic, retain) IBOutlet UITableView *settingsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *newSurveyAlertCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *locationSpecificSurveyCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *sortSurveyCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *fewestQuestionsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *locationCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *sortCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *newestQuestionsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *confirmationCell;
@property (nonatomic, retain) IBOutlet UIButton *newSurveyAlertButton;
@property (nonatomic, retain) IBOutlet UIButton *locatonSpecificSurveyButton;
@property (nonatomic, retain) IBOutlet UILabel *sortSurveyLabel;

@end
