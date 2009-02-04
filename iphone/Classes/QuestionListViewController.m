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
#import "QuestionList.h"
#import "Survey.h"

@implementation QuestionListViewController

@synthesize surveyId = _surveyId;
@synthesize surveyName = _surveyName;
@synthesize questions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)survey {  
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.surveyId = survey.itemId;
    self.surveyName = survey.name;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    self.navigationItem.title = @"Questions";
    self.questions = [[QuestionList alloc] init];
    
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
    [self.questions refreshQuestionList];
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
    
    Question *q = [self.questions questionAtIndex:indexPath.row];
    cell.text = [q questionAndAmountAsString];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    SingleQuestionViewController *sqvc = 
        [[SingleQuestionViewController alloc] initWithNibName:@"QuestionView" 
                                                       bundle:nil 
                                                     question:[self.questions questionAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sqvc animated:YES];  
    [sqvc release];    
}


- (void)dealloc {
    [questions release];
	[_surveyId release];
	[_surveyName release];
    [super dealloc];
}


@end

