//
//  EditIncomingController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditIncomingController : UIViewController {
	UITextField *incomingField;
}

@property (nonatomic, retain) IBOutlet UITextField *incomingField;

- (void)cancel;
- (void)save;

@end
