//
//  SurveyController.m
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SurveyController.h"
#import "Survey.h"
#import "Question.h"
#import "QuestionCell.h"
#import "SurveyInfoCell.h"
#import "QuestionController.h"
#import "Answer.h"


@implementation SurveyController
@synthesize questionsTable, survey, questionController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
		backButton.title = @"Back";
		self.navigationItem.backBarButtonItem = backButton;
		[backButton release];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.navigationItem.title = [NSString stringWithFormat:@"%d QUESTIONS", [survey.questions count]];
	[questionsTable reloadData];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.questionsTable = nil;
	self.questionController = nil;
}


- (void)dealloc {
	[questionsTable release]; 
	[survey release];
	[questionController release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [survey.questions count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		static NSString *CellIdentifier = @"SurveyInfoCell";
		
		SurveyInfoCell *cell = (SurveyInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyInfoCellView" owner:self options:nil];
			cell = [nib objectAtIndex:0];
		}
		[cell updateSurvey:survey];
		[cell.takeButton addTarget:self action:@selector(takeSurvey) forControlEvents:UIControlEventTouchUpInside];
		return cell;
	} else {	
		static NSString *CellIdentifier = @"QuestionCell";
		
		QuestionCell *cell = (QuestionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionCellView" owner:self options:nil];
			cell = [nib objectAtIndex:0];
		}
		
		CGFloat height = [self tableView:questionsTable heightForRowAtIndexPath:indexPath];
		Question *question = [survey.questions objectAtIndex:indexPath.row-1];
		[cell setNameLabelFrame:height - 10];
		[cell updateQuestion:question];
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	[self takeSurvey];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat result = 36.0f;
	if (indexPath.row == 0) {
		CGFloat width = 230.0f;
		CGSize textSize = { width, 20000.0f };
		CGSize nameSize = [survey.name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
		CGSize descriptionSize = [survey.description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
		return 66 + nameSize.height + descriptionSize.height;
	} else {
		CGFloat width = 200.0f;
		
		Question *question = (Question *)[survey.questions objectAtIndex:indexPath.row-1];
		NSString *text = question.name;
		
		if (text)
		{
			// The notes can be of any height
			// This needs to work for both portrait and landscape orientations.
			// Calls to the table view to get the current cell and the rect for the 
			// current row are recursive and call back this method.
			CGSize          textSize = { width, 20000.0f };         // width and height of text area
			CGSize          size = [text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
				  
			result = size.height + 4.0f + 10; // top and bottom margin
		}
	}
	
	return result;	
}

- (IBAction)takeSurvey {
	[self.questionController setSurvey:survey];

	NSInteger qidx = 0;
	for (Question *question in survey.questions) {		
		if (question.answer != nil && question.answer.pk > 0) {
			qidx++;
		} else {
			break;
		}
	}
	if (qidx == [survey.questions count]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:@"This survey is already taken. Please choose another survey, thanks."
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	[self.questionController setQuestionIdx:qidx];
	[self.navigationController pushViewController:self.questionController animated:YES];
}

- (QuestionController *)questionController {
	if (questionController == nil) {
		QuestionController *qc = [[QuestionController alloc] initWithNibName:@"QuestionView" bundle:nil];
		self.questionController = qc;
		[qc release];
	}
	return questionController;
}

@end
