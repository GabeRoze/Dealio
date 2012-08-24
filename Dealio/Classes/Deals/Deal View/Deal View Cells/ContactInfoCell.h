//
//  ContactInfoCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-24.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum
{
    phone,
    website,
    address,
}ContactType;

@interface ContactInfoCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}

@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (assign, nonatomic) ContactType contactType;

@end
