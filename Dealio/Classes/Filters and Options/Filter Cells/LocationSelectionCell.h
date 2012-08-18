//
//  LocationSelectionCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationSelectionCell : UITableViewCell
{
    IBOutlet UIButton *GPSButton;
    IBOutlet UIButton *AddressButton;
    IBOutlet  UITextField *addressTextField;
}


@end
