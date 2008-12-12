//
//  SingleQuestionViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleQuestionViewController : UIViewController {
    IBOutlet UILabel *selectedQuestion;

}

@property (nonatomic, retain) UILabel *selectedQuestion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(NSString *)question;

@end
