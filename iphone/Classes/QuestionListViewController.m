//
//  QuestionsViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionListViewController.h"
#import "SingleQuestionViewController.h"
#import "Question.h"
#import "Survey.h"

@implementation QuestionListViewController

@synthesize survey;
@synthesize surveyName;
@synthesize questions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    self.navigationItem.title = @"Questions";
    
    // add our custom button to show our modal view controller
    UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton addTarget:self action:@selector(refreshQuestions) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.rightBarButtonItem = modalButton;
    [modalViewButton release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)refreshQuestions {
    self.questions = [survey questions];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Question *q = [self.questions objectAtIndex:indexPath.row];
    cell.text = [q questionAndAmountAsString];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleQuestionViewController *sqvc = 
        [[SingleQuestionViewController alloc] initWithNibName:@"QuestionView" 
                                                       bundle:nil 
                                                     question:[self.questions objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sqvc animated:YES];  
    [sqvc release];    
}


- (void)dealloc {
    [questions release];
    [survey release];
    [super dealloc];
}


@end

