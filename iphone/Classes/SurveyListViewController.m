//
//  SurveyListViewController.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "SurveyListViewController.h"
#import "QuestionListViewController.h"
#import "Survey.h"

@implementation SurveyListViewController

@synthesize surveys;

- (void)awakeFromNib {
    [Survey findAllWithDelegate:self];
    
    // add our custom button to show our modal view controller
    UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton addTarget:self action:@selector(refreshSurveys) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.rightBarButtonItem = modalButton;
    [modalViewButton release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)itemsReceived:(NSArray *)items {
    self.surveys = items;
    [self.tableView reloadData];
}
    
-(void)refreshSurveys {
    [Survey findAllWithDelegate:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.surveys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Survey *survey = [self.surveys objectAtIndex:indexPath.row];
    cell.text = [survey nameAndAmountAsString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionListViewController *questionListViewController = 
        [[QuestionListViewController alloc] initWithNibName:@"QuestionListView" 
                                            bundle:nil];
    
    questionListViewController.survey = [self.surveys objectAtIndex:indexPath.row];
    [questionListViewController refreshQuestions];
    
    [self.navigationController pushViewController:questionListViewController animated:YES];
    
    [questionListViewController release];    
}

- (void)dealloc {
    [surveys release];
    [super dealloc];
}


@end

