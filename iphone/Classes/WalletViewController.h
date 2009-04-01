//
//  WalletViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WalletViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* entries;
	UILabel* totalTitle;
	UILabel* totalValue;
}

@property (nonatomic, retain) IBOutlet UITableView* entries;
@property (nonatomic, retain) IBOutlet UILabel* totalTitle;
@property (nonatomic, retain) IBOutlet UILabel* totalValue;
@end
