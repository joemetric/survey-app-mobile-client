//
//  WalletController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WalletController : UIViewController {
	UITableView *paymentTable;
	UITableViewCell *paymentHeaderCell;
	
	NSMutableArray *pendingPayments;
}

@property (nonatomic, retain) IBOutlet UITableView *paymentTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *paymentHeaderCell;
@property (nonatomic, retain) NSMutableArray *pendingPayments;

@end
