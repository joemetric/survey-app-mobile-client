//
//  SurveyQuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/13/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "SurveyQuestionViewController.h"
#import "Question.h"


@implementation SurveyQuestionViewController

@synthesize selectedQuestion = _selectedQuestion;
@synthesize selectedQuestionLabel = _selectedQuestionLabel;
@synthesize selectedAmountLabel = _selectedAmountLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)question {    
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.selectedQuestion = question;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    self.selectedQuestionLabel.text = self.selectedQuestion.text;
    self.selectedAmountLabel.text = [self.selectedQuestion amountAsDollarString];    
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
