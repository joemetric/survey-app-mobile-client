//
//  SingleQuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "SingleQuestionViewController.h"


@implementation SingleQuestionViewController

@synthesize selectedQuestion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(NSString *)question {    
    SingleQuestionViewController *controller = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    controller.selectedQuestion.text = question;
    return controller;
}
    
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    NSLog(@"SingleQuestionViewController is initialized");
    return self;
}


// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
    [super loadView];
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {   
    NSLog(@"");
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
    [selectedQuestion release];
    [super dealloc];
}


@end
