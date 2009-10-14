//
//  SurveyCell.h
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Survey;

@interface SurveyCell : UITableViewCell {
	UIButton *priceButton;
	UILabel *nameLabel;
	Survey *survey;
}

@property (nonatomic, retain) IBOutlet UIButton *priceButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) Survey *survey;

- (void)updateSurvey:(Survey *)s;

@end
