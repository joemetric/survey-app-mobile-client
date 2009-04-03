//
//  WalletViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewTableCell.h"


@implementation WalletViewController

@synthesize entries;
@synthesize totalTitle, totalValue;

- (void) viewWillAppear:(BOOL)animated {
	totalValue.text = @"$6.00";
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WalletViewTableCell *cell = (WalletViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"WalletViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"WalletViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell
	if (indexPath.row == 3){
		cell.surveyName.text  = @"Withdrawal";
		cell.surveyValue.text = @"$-5.00";
		[cell setupAsDebit];
	}
	else {
		cell.surveyName.text = [NSString stringWithFormat:@"Survey %d", indexPath.row+1];
		cell.surveyValue.text = [NSString stringWithFormat:@"$%d.00", (indexPath.row+1)];
		[cell setupAsCredit];
	}
	if( indexPath.row % 2 == 1 ) {
		cell.backgroundColor = [UIColor lightGrayColor];
	} else {
		cell.backgroundColor = [UIColor whiteColor];
	}
    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end

