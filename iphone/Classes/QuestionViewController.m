//
//  QuestionViewController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"

@implementation QuestionViewController

@synthesize amountLabel;
@synthesize questionLabel;
@synthesize question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibBundleOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;
    }
    return self;
}

    
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionLabel.text = self.question.text;
    self.amountLabel.text = [self.question amountAsDollarString];
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

- (void)answerQuestion:(id)sender
{
}

- (void)dealloc {
    [questionLabel release];
    [amountLabel release];
    [question release];
    [super dealloc];
}


@end
