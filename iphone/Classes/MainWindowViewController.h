//
//  MainWindowViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainWindowViewController : UITableViewController {
    id delegate;
}

@property (nonatomic, assign) id delegate;
@end
