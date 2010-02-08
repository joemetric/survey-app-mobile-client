//
//  SurveyCompletion.h
//  Survey
//
//  Created by mobile06 on 22/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrowseController,Survey,SettingsController;
@interface SurveyCompletion : UIViewController {
	UIButton	*charityOrganizationImage1;
	UIButton	*charityOrganizationImage2;
	UIButton	*charityOrganizationImage3;
	UIButton	*charityOrganizationImage4;
	UIButton	*charityOrganizationImage5;
	
	UILabel		*earnedAmountLabel;
	UILabel		*donationAmountToCharityLabel;
	UILabel		*earnedAmountMessageLabel;
	UILabel		*genourisityLabel;
	NSString	*donatedPercernatge;
	NSInteger   selectedPercentage;
	BrowseController *browseController;
	SettingsController *settingsController;
	float percetageCheck;
	float surveyAmount;
	float initialAmount;
}

@property(nonatomic,retain) IBOutlet UIButton	*charityOrganizationImage1;
@property(nonatomic,retain) IBOutlet UIButton	*charityOrganizationImage2;
@property(nonatomic,retain) IBOutlet UIButton	*charityOrganizationImage3;
@property(nonatomic,retain) IBOutlet UIButton	*charityOrganizationImage4;
@property(nonatomic,retain) IBOutlet UIButton	*charityOrganizationImage5;
@property(nonatomic,retain) IBOutlet UILabel	*earnedAmountLabel;
@property(nonatomic,retain) IBOutlet UILabel	*donationAmountToCharityLabel; 
@property(nonatomic,retain) IBOutlet UILabel	*earnedAmountMessageLabel; 
@property(nonatomic,retain) IBOutlet UILabel	*genourisityLabel; 

@property(nonatomic,retain) BrowseController	*browseController;
@property(nonatomic,retain) NSString			*donatedPercernatge;

@property(nonatomic,retain) 	SettingsController *settingsController;



- (IBAction) saveAmountAndGotoMainScreenClicked:(UIButton*)image;
- (float) earnedAmountByUser:(float) percentage;

@end
