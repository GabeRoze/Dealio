//
//  DealViewUrlCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewUrlCell.h"

@implementation DealViewUrlCell

@synthesize url;
@synthesize urlLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setUrl:(NSString*)n{
    if (![n isEqualToString:url]){
        url = [n copy];
        urlLabel.text = url;
    }
}

@end
