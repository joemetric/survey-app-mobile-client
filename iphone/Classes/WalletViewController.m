//
//  WalletViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewTableCell.h"
#import "Account.h"


@implementation WalletViewController

@synthesize entries;
@synthesize totalTitle, totalValue;

- (void) viewDidLoad {
	entries.separatorColor = [UIColor darkGrayColor];
}

- (void) viewWillAppear:(BOOL)animated {
	if( [Account currentAccount] != nil ) {
		NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[numberFormatter setCurrencySymbol:@"$"];
		[numberFormatter setMaximumFractionDigits:2];
		[numberFormatter setMinimumFractionDigits:2];
		totalValue.text = [numberFormatter stringFromNumber:[[Account currentAccount] walletBalance]];
		[numberFormatter release];
	}
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if( [Account currentAccount] != nil ) {
		return [Account currentAccount].walletTransactionCount;
	} else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletViewTableCell *cell = (WalletViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"WalletViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"WalletViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
	NSDictionary* wallet_transaction = [[[Account currentAccount].wallet objectForKey:@"wallet_transactions"] objectAtIndex:indexPath.row];
    // Configure the cell
	cell.surveyName.text  = [wallet_transaction objectForKey:@"description"];
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	cell.surveyValue.text = [numberFormatter stringFromNumber:[wallet_transaction objectForKey:@"amount"]];
	[numberFormatter release];
	if( [[wallet_transaction objectForKey:@"description"] isEqualToString:@"Withdrawal"] )
	  [cell setupAsDebit];
	else
		[cell setupAsCredit];

	if( indexPath.row % 2 == 1 ) {
		cell.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	} else {
		cell.contentView.backgroundColor = [UIColor whiteColor];
	}
    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end

