//
//  FreeTextAnswerController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "FreetextAnswerViewController.h"
#import "Question.h"
#import "Answer.h"
#import "QuestionListViewController.h"
#import "AnswerManager.h"

@implementation FreetextAnswerViewController

@synthesize question;
@synthesize questionList;
@synthesize questionLabel, questionDetails;
@synthesize answerField, answerFieldBorder;

@synthesize keyboardIsShowing;
- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];	
	self.questionLabel.text = self.question.name;
	self.questionDetails.text = self.question.text;
	
	[super viewWillAppear:animated];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    if (self.keyboardIsShowing == NO)
    {
        self.keyboardIsShowing = YES;
        CGRect frame = self.answerField.frame;
		CGRect outerFrame = self.answerFieldBorder.frame;
		CGRect windowFrame = self.view.frame;
		
        frame.size.height -= (keyboardHeight - 40);
        outerFrame.size.height -= (keyboardHeight - 40);
		windowFrame.origin.y -= 40;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
		self.answerFieldBorder.frame = outerFrame;
        self.answerField.frame = frame;
		self.view.frame = windowFrame;
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing:)] autorelease];
        [UIView commitAnimations];
    }
}

-(void) keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    if (self.keyboardIsShowing == YES)
    {
        self.keyboardIsShowing = NO;
        CGRect frame = self.answerField.frame;
		CGRect outerFrame = self.answerFieldBorder.frame;
		CGRect windowFrame = self.view.frame;
        frame.size.height += (keyboardHeight - 40);
        outerFrame.size.height += (keyboardHeight - 40);
		windowFrame.origin.y += 40;
		
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
		self.answerFieldBorder.frame = outerFrame;
        self.answerField.frame = frame;
		self.view.frame = windowFrame;
		self.navigationItem.rightBarButtonItem = nil;
        [UIView commitAnimations];
    }
}

- (void)doneEditing:(id)sender {
	[self.answerField resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)submitAnswer:(id)sender {
    NSLog(@"Submitting answer");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:question.itemId] forKey:@"question_id"];
    [params setObject:question.questionType forKey:@"question_type"];
    [params setObject:answerField.text forKey:@"answer_string"];

    Answer *answer = [Answer newFromDictionary:params];
    [answer store];
    [AnswerManager pushAnswer:answer];
    NSLog(@"Answer: %@", answer);
    
    [self.navigationController popToViewController:self.questionList animated:YES];

    [params release];
    [answer release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [question release];
    [questionList release];
    [super dealloc];
}


@end
