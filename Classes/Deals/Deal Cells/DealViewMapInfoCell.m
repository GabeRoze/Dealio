//
//  DealViewMapInfoCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewMapInfoCell.h"

@implementation DealViewMapInfoCell
@synthesize streetAddressLabel;
@synthesize cityAddressLabel;
@synthesize cityAddress;
@synthesize streetAddress;


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



-(void)setStreetAddress:(NSString*)n{
    if (![n isEqualToString:streetAddress]){
        streetAddress = [n copy];
        streetAddressLabel.text = streetAddress;
    }
}

-(void)setCityAddress:(NSString*)n{
    if (![n isEqualToString:cityAddress]){
        cityAddress = [n copy];
        cityAddressLabel.text = cityAddress;
    }
}

@end
