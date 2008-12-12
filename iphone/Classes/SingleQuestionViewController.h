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
    NSString *textForSelectedQuestion;

}

@property (nonatomic, retain) UILabel *selectedQuestion;
@property (nonatomic, retain) NSString *textForSelectedQuestion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(NSString *)question;

@end
