//
//  SingleQuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "SingleQuestionViewController.h"


@implementation SingleQuestionViewController

@synthesize selectedQuestion = _selectedQuestion;
@synthesize selectedAmount = _selectedAmount;
@synthesize textForSelectedQuestion = _textForSelectedQuestion;
@synthesize textForSelectedAmount = _textForSelectedAmount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)question {    
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.textForSelectedQuestion = question.text;
    self.textForSelectedAmount = [question amountAsDollarString];
    return self;
}
    
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
    [super loadView];
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {   
    self.selectedQuestion.text = self.textForSelectedQuestion;
    self.selectedAmount.text = self.textForSelectedAmount;
    self.navigationItem.backBarButtonItem.title = @"Back";
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
    [self.selectedQuestion release];
    [self.selectedAmount release];
    [self.textForSelectedAmount release];
    [self.textForSelectedQuestion release];
    [super dealloc];
}


@end
