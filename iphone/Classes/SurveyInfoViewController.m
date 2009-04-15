//
//  SurveyInfoViewController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "SurveyInfoViewController.h"
#import "PictureAnswerViewController.h"
#import "FreetextAnswerViewController.h"
#import "Survey.h"
#import "Question.h"
#import "Answer.h"
#import "SurveyInfoViewTableCell.h"

@interface SurveyInfoViewController (Private)
- (BOOL) allQuestionsAnswered;
@end

@implementation SurveyInfoViewController

@synthesize surveyName;
@synthesize surveyAmount;
@synthesize survey;
@synthesize surveyDescription;
@synthesize questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)aSurvey {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.survey = aSurvey;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.surveyName.text = self.survey.name;
    self.surveyAmount.text = [self.survey amountAsDollarString];
	[Answer clearAllStored];
	UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(surveyCancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	self.title = @"Survey";
	[cancelButton release];
}

- (void) surveyDone:(id)sender {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"TODO" message:@"Submit answers to the server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) surveyCancel:(id)sender {
	//TODO show an alert informing the user that all answers deleted if they proceed.
	[Answer clearAllStored];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
	NSLog(@"numSec");
	return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	NSLog(@"numRow");
	return [survey.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"cell");
    SurveyInfoViewTableCell *cell = (SurveyInfoViewTableCell*)[tv dequeueReusableCellWithIdentifier:@"SurveyInfoViewTableCell"];
	NSLog(@"cell:deq");
	
    if (cell == nil) {
		NSLog(@"cell:nib");
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyInfoViewTableCell" owner:self options:nil];
		NSLog(@"cell:objAt");
        cell = [nib objectAtIndex:0];
		NSLog(@"cell:objAt:done");
    }
	NSLog(@"cell:quest");

	Question* q = (Question*)[survey.questions objectAtIndex:indexPath.row]; 
	NSLog(@"cell:text");
	cell.textLabel.text = q.name;
	NSLog(@"cell:image");
	if( [Answer answerExistsForQuestion:q] )
		cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"question_%@_done.png", q.questionType]];
	else
		cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"question_%@.png", q.questionType]];
		
	NSLog(@"cell:return");
	return cell;
}


- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Question* q = [self.survey.questions objectAtIndex:indexPath.row];

	if( [q.questionType isEqualToString:@"picture"] ) {
		PictureAnswerViewController* pac = [[PictureAnswerViewController alloc] initWithNibName:@"PictureAnswerView" 
																				bundle:nil
																				question:q];
		[self.navigationController pushViewController:pac animated:YES];  
		[pac release];    
	} else 	if( [q.questionType isEqualToString:@"freetext"] ) {
		FreetextAnswerViewController* fac = [[FreetextAnswerViewController alloc] initWithNibName:@"FreetextAnswerView" 
																						 bundle:nil
																					   question:q];
		   [self.navigationController pushViewController:fac animated:YES];  
		[fac release];    
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[self.questionList reloadData];
	if( [self allQuestionsAnswered] == YES && self.navigationItem.rightBarButtonItem == nil ) {
		UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(surveyDone:)];
		self.navigationItem.rightBarButtonItem = doneButton;
		[doneButton release];
	} else {
		self.navigationItem.rightBarButtonItem = nil;
	}
}

- (BOOL) allQuestionsAnswered {
	for( Question* q in self.survey.questions ) {
		if( [Answer answerExistsForQuestion:q] == NO )
			return NO;
	}
	return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
