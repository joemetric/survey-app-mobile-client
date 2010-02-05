//
//  SurveyCompletion.m
//  Survey
//
//  Created by mobile06 on 22/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "SurveyAppDelegate.h"
#import "SurveyCompletion.h"
#import "BrowseController.h"
#import "Survey.h"
#import "SettingsController.h"
@implementation SurveyCompletion

@synthesize charityOrganizationImage1, charityOrganizationImage2, charityOrganizationImage3;
@synthesize charityOrganizationImage4, charityOrganizationImage5;
@synthesize earnedAmountLabel,donationAmountToCharityLabel,browseController,donatedPercernatge;
@synthesize genourisityLabel,earnedAmountMessageLabel,settingsController;

- (void)viewDidLoad {
	[super viewDidLoad];
	initialAmount  = [settingsController.selectedPercentage.text floatValue];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(donationPercentageChanged:)
												 name:@"selectedPercentageToDonate" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"broadcastDonationpercentage" object:nil];
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	Survey* survey = delegate.browseController.surveyAmt;
	surveyAmount = [survey.total_payout floatValue]; 
	
	donationAmountToCharityLabel.text =	@"$0.0";
	earnedAmountLabel.text = [NSString stringWithFormat:@"$%0.2f",surveyAmount];
	
}

- (void) donationPercentageChanged:(NSNotification*) notification {
	donatedPercernatge = [notification object];
	percetageCheck = [donatedPercernatge floatValue];
	float earnedAmount = 	[self earnedAmountByUser:percetageCheck];
	if (percetageCheck == 100) {
		earnedAmountMessageLabel.hidden = YES;
		earnedAmountLabel.hidden = YES;
		genourisityLabel.hidden = NO;
		genourisityLabel.text = @"Thank You For Your Generousity";
	}else {
		earnedAmountMessageLabel.hidden = NO;
		earnedAmountLabel.hidden = NO;
		genourisityLabel.hidden = YES;
		earnedAmountLabel.text = [NSString stringWithFormat:@"$%0.2f",earnedAmount];
	}
}
	
- (float) earnedAmountByUser:(float) percentage {
	float earnedAmount = 0.0; 
	float totalAmountToDonated = 0.0;
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	Survey* survey = delegate.browseController.surveyAmt;
	surveyAmount = [survey.total_payout floatValue]; 
	percentage = [donatedPercernatge floatValue];
	earnedAmount = surveyAmount - (percentage * surveyAmount) / 100.0;  
	totalAmountToDonated = (surveyAmount * (percentage + 10.0)) / 100.0;
	donationAmountToCharityLabel.text = [NSString stringWithFormat:@"$%0.2f",totalAmountToDonated];
	return earnedAmount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.charityOrganizationImage1 = nil;
	self.charityOrganizationImage2 = nil;
	self.charityOrganizationImage3 = nil;
	self.charityOrganizationImage4 = nil;
	self.charityOrganizationImage5 = nil;
	self.earnedAmountLabel = nil;
	self.donationAmountToCharityLabel = nil;
}

- (void)dealloc {
	[charityOrganizationImage1 release];
	[charityOrganizationImage2 release];
	[charityOrganizationImage3 release];
	[charityOrganizationImage4 release];
	[charityOrganizationImage5 release];
	[earnedAmountLabel release];
	[donationAmountToCharityLabel release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedPercentageToDonate" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"amountPerSurvey" object:nil];

	[super dealloc];
}

#pragma mark -
#pragma mark own class's FUNCTION

- (IBAction) saveAmountAndGotoMainScreenClicked:(UIButton*)image {
		if(image == charityOrganizationImage1) {
			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage2) {
			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage3){
			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage4){
			[self.view removeFromSuperview];
		}
		else{
			[self.view removeFromSuperview];
		}
}

@end