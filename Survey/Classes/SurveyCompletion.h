//
//  SurveyCompletion.h
//  Survey
//
//  Created by mobile06 on 22/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestRequest.h"
#import "JSON.h"

@class User,Metadata;

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
	
	UILabel		*imageLabel1;
	UILabel		*imageLabel2;
	UILabel		*imageLabel3;
	UILabel		*imageLabel4;
	UILabel		*imageLabel5;
	
	NSMutableData *responseData;
	NSURLConnection* connection;
	NSString	*donatedPercernatge;
	NSInteger   selectedPercentage;
	
	Survey *sur;
	Metadata *metadata;
	BrowseController *browseController;
	SettingsController *settingsController;
	float percetageCheck;
	float surveyAmount;
	float initialAmount;
	float amount_earned;
	float amountToDonate;
	int organizationId;
	
	

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

@property(nonatomic,retain) IBOutlet 	UILabel		*imageLabel1;
@property(nonatomic,retain) IBOutlet 	UILabel		*imageLabel2;
@property(nonatomic,retain) IBOutlet 	UILabel		*imageLabel3;
@property(nonatomic,retain) IBOutlet 	UILabel		*imageLabel4;
@property(nonatomic,retain) IBOutlet 	UILabel		*imageLabel5;

@property(nonatomic,retain) BrowseController	*browseController;
@property(nonatomic,retain) NSString			*donatedPercernatge;

@property(nonatomic,retain) SettingsController *settingsController;
@property(nonatomic,retain) Metadata *metadata;
- (void) displayLogo;
- (IBAction) saveAmountAndGotoMainScreenClicked:(UIButton*)image;
- (float) earnedAmountByUser:(float) percentage;
- (void) calulateAmount;
@end
