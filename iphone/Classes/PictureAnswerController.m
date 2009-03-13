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

        snapshotButtonIndex = libraryButtonIndex = cancelButtonIndex = -1;
        
        menu = [[UIActionSheet alloc] init];
        menu.delegate = self;
        menu.title = @"Choose an image to send";

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            snapshotButtonIndex = menu.numberOfButtons;
            [menu addButtonWithTitle:@"Take Snapshot"];
        }

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            libraryButtonIndex = menu.numberOfButtons;
            [menu addButtonWithTitle:@"Library Photo"];
        }

        cancelButtonIndex = menu.numberOfButtons;
        [menu addButtonWithTitle:@"Cancel"];
        
        menu.cancelButtonIndex = cancelButtonIndex;
    }
    return self;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == cancelButtonIndex) {
        return;
    }
    
    UIImagePickerController *p = [[UIImagePickerController alloc] init];
    p.delegate = self;

    if (buttonIndex == snapshotButtonIndex) {
        p.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        p.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
        
    [self presentModalViewController:p animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [menu showInView:[self view]];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    imageView.image = image;
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendAnswer:(id)sender
{
    NSLog(@"Submitting picture");
}

- (IBAction)changePicture:(id)sender
{
    [menu showInView:[self view]];
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
    [question release];
    [menu release];
    [super dealloc];
}


@end
