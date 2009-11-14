//
//  SurveyCell.m
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SurveyCell.h"
#import "Survey.h"


@implementation SurveyCell
@synthesize priceButton, nameLabel, survey;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)dealloc {
	[priceButton release];
	[nameLabel release];
	[survey release];
	
	[super dealloc];
}

- (void)updateSurvey:(Survey *)s {
	self.survey = s;
	self.nameLabel.text = self.survey.name;
	[self.priceButton setTitle:self.survey.pricing forState:UIControlStateNormal];
}

@end
