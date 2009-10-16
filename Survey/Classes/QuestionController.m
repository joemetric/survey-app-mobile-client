//
//  QuestionController.m
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "QuestionController.h"
#import "Survey.h"
#import "Question.h"


@interface QuestionController (Private)
- (void)buildView;
- (void)submit;
@end

@implementation QuestionController
@synthesize nameLabel, descLabel, answerField, takeButton, choicePicker;
@synthesize survey, questionIdx, question;
@synthesize nextQuestionController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
		backButton.title = @"Back";
		self.navigationItem.backBarButtonItem = backButton;
		[backButton release];
		UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
		self.navigationItem.rightBarButtonItem = submitButton;
		[submitButton release];
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
	self.navigationItem.title = [NSString stringWithFormat:@"QUESTION %d OF %d", questionIdx + 1, [survey.questions count]];	
	[self buildView];
}

- (void)buildView {
	CGSize textSize = { 230, 20000.0f };
	CGSize nameSize = [self.question.name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	CGRect nameFrame = nameLabel.frame;
	nameFrame.size.height = nameSize.height + 4;
	[nameLabel setFrame:nameFrame];
	CGSize descSize = [self.question.description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	CGRect descFrame = descLabel.frame;
	descFrame.size.height = descSize.height + 4;
	[descLabel setFrame:descFrame];

	if ([self.question isShortAnswer]) {
		CGRect answerFrame = answerField.frame;
		answerFrame.origin.y = descFrame.origin.y + descFrame.size.height + 20;
		[answerField setFrame:answerFrame];
		answerField.hidden = FALSE;
		takeButton.hidden = TRUE;
		choicePicker.hidden = TRUE;
	} else if ([self.question isPhotoUpload]) {
		CGRect takeFrame = takeButton.frame;
		takeFrame.origin.y = descFrame.origin.y + descFrame.size.height + 20;
		[takeButton setFrame:takeFrame];
		takeButton.hidden = FALSE;
		answerField.hidden = TRUE;
		choicePicker.hidden = TRUE;
	} else if ([self.question isMultipleChoice]) {
		CGRect choiceFrame = choicePicker.frame;
		choiceFrame.origin.y = descFrame.origin.y + descFrame.size.height + 20;
		[choicePicker setFrame:choiceFrame];
		choicePicker.hidden = FALSE;
		answerField.hidden = TRUE;
		takeButton.hidden = TRUE;
	} else {
		choicePicker.hidden = TRUE;
		answerField.hidden = TRUE;
		takeButton.hidden = TRUE;
	}
	
	nameLabel.text = self.question.name;
	descLabel.text = self.question.description;
}

- (void)submit {
	if (questionIdx + 1 == [survey.questions count]) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	} else {
		[self.nextQuestionController setSurvey:survey];
		[self.nextQuestionController setQuestionIdx:questionIdx+1];
		[self.navigationController pushViewController:self.nextQuestionController animated:YES];
	}
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
}


- (void)dealloc {
	[survey release];
	[question release];
	[nextQuestionController release];
	
    [super dealloc];
}


- (Question *)question {
	if (question == nil)
		question = [survey.questions objectAtIndex:questionIdx];
	return question;
}

- (QuestionController *)nextQuestionController {
	if (nextQuestionController == nil) {
		QuestionController *qc = [[QuestionController alloc] initWithNibName:@"QuestionView" bundle:nil];
		self.nextQuestionController = qc;
		[qc release];
	}
	return nextQuestionController;
}


#pragma mark -
#pragma mark Multiple Choice Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (UILabel *)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 280.0, 44.0)] autorelease];
	}
	
	retval.text = [question.complement objectAtIndex:row];
	retval.font = [UIFont boldSystemFontOfSize:20];
	retval.backgroundColor = [UIColor clearColor];
	retval.textAlignment = UITextAlignmentCenter;
	
	return retval;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [question.complement count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
}

@end