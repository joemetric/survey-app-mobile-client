//
//  PictureAnswerController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "PictureAnswerController.h"
#import "Question.h"


@implementation PictureAnswerController

@synthesize question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;
    }
    return self;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 2) {
        UIImagePickerController *p = [[UIImagePickerController alloc] init];
        p.delegate = self;
        
        if (buttonIndex == 0) {
            p.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            p.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [self presentModalViewController:p animated:YES];
    }

    [actionSheet release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.delegate = self;
    menu.title = @"Choose an image to send";
    [menu addButtonWithTitle:@"Take Snapshot"];
    [menu addButtonWithTitle:@"Library Photo"];
    [menu addButtonWithTitle:@"Cancel"];
    menu.cancelButtonIndex = 2;

    [menu showInView:[self view]];
    // CLANG reports menu as leaking, but it isn't.  It's released above.
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
