//
//  SurveyInfoCell.h
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survey.h"


@interface SurveyInfoCell : UITableViewCell {
	UIButton *priceButton;
	UILabel *nameLabel;
	UILabel *descriptionLabel;
	UIButton *takeButton;
	
	Survey *survey;
}

@property (nonatomic, retain) IBOutlet UIButton *priceButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UIButton *takeButton;
@property (nonatomic, retain) Survey *survey;

- (void)updateSurvey:(Survey *)s;

@end
