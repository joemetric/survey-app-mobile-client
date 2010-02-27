//
//  SurveyCompletion.m
//  Survey
//
//  Created by mobile06 on 22/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "SurveyRestRequest.h"

#import "RestRequest.h"
#import "Common.h"
#import "JSON.h"
#import "QuestionController.h"
#import "SurveyController.h"
#import "SurveyAppDelegate.h"
#import "SurveyCompletion.h"
#import "BrowseController.h"
#import "Survey.h"
#import "SettingsController.h"
#import "NSStringExt.h"
#import "User.h"
#import "Metadata.h"
@implementation SurveyCompletion

@synthesize charityOrganizationImage1, charityOrganizationImage2, charityOrganizationImage3;
@synthesize charityOrganizationImage4, charityOrganizationImage5;
@synthesize earnedAmountLabel,donationAmountToCharityLabel,browseController,donatedPercernatge;
@synthesize genourisityLabel,earnedAmountMessageLabel,settingsController;
@synthesize imageLabel1,imageLabel2,imageLabel3,imageLabel4,imageLabel5;
- (void)viewDidLoad {
	[super viewDidLoad];
	[self displayLogo];
#if 0
	
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	Survey* survey = delegate.browseController.surveyAmt;
	surveyAmount = [survey.total_payout floatValue];
	float amountToDonate =  (surveyAmount * (0.0 + 10.0)) / 100.0;
	earnedAmountLabel.text = [NSString stringWithFormat:@"$%0.2f",surveyAmount];
	donationAmountToCharityLabel.text = [NSString stringWithFormat:@"$%0.2f",amountToDonate];
	
#endif
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(donationPercentageChanged:)
												 name:@"selectedPercentageToDonate" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"broadcastDonationpercentage" object:nil];
	[self calulateAmount];

}

- (void) displayLogo {
		
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/charityorgs/activeCharityOrgs.json", ServerURL];
	NSURL *jsonURL = [NSURL URLWithString:baseUrl];
	NSString *jsonData = [[NSString alloc] initWithContentsOfURL:jsonURL];
	SBJSON* json = [SBJSON alloc];
	NSArray* jsonArray =  [json objectWithString:jsonData error:nil];
	for(int i = 0; i < [jsonArray count]; ++i)
	{
		NSArray* itemArray = [jsonArray objectAtIndex:i];
		NSURL* imgUrl = [NSURL URLWithString:[itemArray objectAtIndex:2]];
		UIImage* image0 = nil,*image1 = nil, *image2 = nil,*image3 = nil,*image4 = nil;
		switch(i)
		{
			case 0:
				image0 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
				[charityOrganizationImage1 setBackgroundImage:image0 forState:UIControlStateNormal];
				[imageLabel1 setText:[itemArray objectAtIndex:1]];
				break;
			case 1:
				image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
				[charityOrganizationImage2 setBackgroundImage:image1 forState:UIControlStateNormal];
				[imageLabel2 setText:[itemArray objectAtIndex:1]];
				break;
			case 2:
				image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
				[charityOrganizationImage3 setBackgroundImage:image2 forState:UIControlStateNormal];
				[imageLabel3 setText:[itemArray objectAtIndex:1]];
				break;
			case 3:
				image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
				[charityOrganizationImage4 setBackgroundImage:image3 forState:UIControlStateNormal];
				[imageLabel4 setText:[itemArray objectAtIndex:1]];
				break;
			case 4:
				image4 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
				[charityOrganizationImage5 setBackgroundImage:image4 forState:UIControlStateNormal];
				[imageLabel5 setText:[itemArray objectAtIndex:1]];

				break;
			default:
				break;
		}
	}
	[jsonData release];
}

- (void) donationPercentageChanged:(NSNotification*) notification {
	donatedPercernatge = [[notification object] retain];
}

- (void) calulateAmount{
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	Survey* survey = delegate.browseController.surveyAmt;
	surveyAmount = [survey.total_payout floatValue]; 
	percetageCheck = 0.0;
	percetageCheck = [donatedPercernatge floatValue];
	
	amountToDonate =  (surveyAmount * (percetageCheck + 10.0)) / 100.0;
	float earnedAmount = 	[self earnedAmountByUser:percetageCheck];
	
	if (percetageCheck == 100) {
		earnedAmountMessageLabel.hidden = YES;
		earnedAmountLabel.hidden = YES;
		genourisityLabel.hidden = NO;
		genourisityLabel.text = @"Thank You For Your Generousity";
		donationAmountToCharityLabel.text = [NSString stringWithFormat:@"$%0.2f",amountToDonate];
	}else {
		earnedAmountMessageLabel.hidden = NO;
		earnedAmountLabel.hidden = NO;
		donationAmountToCharityLabel.hidden = NO; 
		genourisityLabel.hidden = YES;
		earnedAmountLabel.text = [NSString stringWithFormat:@"$%0.2f",earnedAmount];
    	donationAmountToCharityLabel.text = [NSString stringWithFormat:@"$%0.2f",amountToDonate];
	}
}
	
- (float) earnedAmountByUser:(float) percentage {
	float earnedAmount = 0.0; 
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	Survey* survey = delegate.browseController.surveyAmt;
	surveyAmount = [survey.total_payout floatValue]; 
	percentage = [donatedPercernatge floatValue];
	earnedAmount = surveyAmount - (percentage * surveyAmount) / 100.0;  
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
	self.donatedPercernatge = nil;
}

- (void)dealloc {
	[charityOrganizationImage1 release];
	[charityOrganizationImage2 release];
	[charityOrganizationImage3 release];
	[charityOrganizationImage4 release];
	[charityOrganizationImage5 release];
	[earnedAmountLabel release];
	[donationAmountToCharityLabel release];
	[donatedPercernatge release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[super dealloc];
}

#pragma mark -


- (IBAction) saveAmountAndGotoMainScreenClicked:(UIButton*)image {
	SurveyAppDelegate* delegate = (SurveyAppDelegate*)[[UIApplication sharedApplication]  delegate];
	QuestionController* ques = delegate.browseController.surveyController.questionController;
	Survey *surveyToDelete = ques.survey;

	int  image_id1,image_id2,image_id3,image_id4,image_id5;
	Survey* survey = delegate.browseController.surveyAmt;
	NSInteger survey_Id =survey.pk ;
	User* userId = delegate.metadata.user;
	int user_Id = [userId.pk intValue];
	NSString *earned_amount = [NSString stringWithFormat:@"%0.2f",amountToDonate]; 
	BOOL result = FALSE;
	NSError *error = nil;
	
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/charityorgs/activeCharityOrgs.json", ServerURL];
	NSURL *jsonURL = [NSURL URLWithString:baseUrl];
	NSString *jsonData = [[NSString alloc] initWithContentsOfURL:jsonURL];
	SBJSON* json = [SBJSON alloc];
	NSArray* jsonArray =  [json objectWithString:jsonData error:nil];

	for(int i = 0; i < [jsonArray count]; ++i)
	{
		NSArray* itemArray = [jsonArray objectAtIndex:i];
	switch(i)
		{
			case 0:
				image_id1 =[[itemArray objectAtIndex:0]intValue];
				break;
			case 1:
				image_id2 =[[itemArray objectAtIndex:0]intValue];
				break;
			case 2:
				image_id3 =[[itemArray objectAtIndex:0]intValue];
				break;
			case 3:
				image_id4 =[[itemArray objectAtIndex:0]intValue];
				break;
			case 4:
				image_id5 =[[itemArray objectAtIndex:0]intValue];
				break;
			default:
				break;
		}
	}
	
	if(image == charityOrganizationImage1) {
		[delegate.browseController removeSurvey:surveyToDelete];
		
		result = [RestRequest OrganizationId:image_id1 SurveyId:survey_Id UserId:user_Id amount_earned:earned_amount Error:&error];

			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage2) {
			[delegate.browseController removeSurvey:surveyToDelete];
			result = [RestRequest OrganizationId:image_id2 SurveyId:survey_Id UserId:user_Id amount_earned:earned_amount Error:&error];

			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage3){
			[delegate.browseController removeSurvey:surveyToDelete];
			
			result = [RestRequest OrganizationId:image_id3 SurveyId:survey_Id UserId:user_Id amount_earned:earned_amount Error:&error];
			
			
			[self.view removeFromSuperview];
		}
		else if(image == charityOrganizationImage4){
			[delegate.browseController removeSurvey:surveyToDelete];
			
			result = [RestRequest OrganizationId:image_id4 SurveyId:survey_Id UserId:user_Id amount_earned:earned_amount Error:&error];
			
			
			[self.view removeFromSuperview];
		}
		else{
			[delegate.browseController removeSurvey:surveyToDelete];
			
			result = [RestRequest OrganizationId:image_id5 SurveyId:survey_Id UserId:user_Id amount_earned:earned_amount Error:&error];
			
			
			[self.view removeFromSuperview];
		}
}

@end