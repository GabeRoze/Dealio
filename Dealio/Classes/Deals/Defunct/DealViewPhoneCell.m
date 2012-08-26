//
//  DealViewPhoneCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewPhoneCell.h"

@implementation DealViewPhoneCell

@synthesize phone;
@synthesize phoneLabel;

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



-(void)setPhone:(NSString*)n{
    if (![n isEqualToString:phone]){
        phone = [n copy];
        phoneLabel.text = phone;
    }
}


@end
