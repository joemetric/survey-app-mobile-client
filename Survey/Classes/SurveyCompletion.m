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
@implementation SurveyCompletion

@synthesize charityOrganizationImage1, charityOrganizationImage2, charityOrganizationImage3;
@synthesize charityOrganizationImage4, charityOrganizationImage5;
@synthesize earnedAmountLabel,donationAmountToCharityLabel,browseController,donatedPercernatge;
@synthesize genourisityLabel,earnedAmountMessageLabel;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(donationPercentageChanged:)
												 name:@"selectedPercentageToDonate" object:nil];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"broadcastDonationpercentage" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amountPerSurvey:)
												 name:@"amountPerSurvey" object:nil];
}

- (void) amountPerSurvey:(NSNotification*) notification
{
	 amt = [notification object];
}

- (void) donationPercentageChanged:(NSNotification*) notification
{
 
	donatedPercernatge = [notification object];
	percetageCheck = [donatedPercernatge floatValue];
	float tmpAmt = 	[self earnedAmountByUser:percetageCheck];
		
	if (percetageCheck == 100)	{
		earnedAmountMessageLabel.hidden = YES;
		earnedAmountLabel.hidden = YES;
		genourisityLabel.hidden = NO;
		genourisityLabel.text = @"Thank You For Your Generousity";
	}
	else {
	earnedAmountLabel.text = [NSString stringWithFormat:@"$%0.2f",tmpAmt];
	}
}

- (float) earnedAmountByUser:(float) percentage
{
	float earnedAmount; 
	percentage = [donatedPercernatge floatValue];
	earnedAmount = 90.00 - (percentage * 90.0) / 100.0;  
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

- (IBAction) saveAmountAndGotoMainScreenClicked:(UIButton*)image{
		if(image == charityOrganizationImage1)
		{
			NSLog([NSString stringWithFormat:@"%f",amt]);
			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage2){
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

//- (BrowseController *) browseController {
//	if (browseController == nil) {
//		BrowseController *bc = [[BrowseController alloc] initWithNibName:@"BrowseView" bundle:nil];
//		self.browseController = bc;
//		[bc release];
//	}
//	return browseController;
//}

@end
