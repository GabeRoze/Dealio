//
//  LocationSelectionCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@interface LocationSelectionCell : UITableViewCell
{
    IBOutlet UIButton *gpsButton;
    IBOutlet UIButton *addressButton;
    IBOutlet  UITextField *addressTextField;
}

- (IBAction)gpsButtonTapped:(id)sender;
- (IBAction)addressButtonTapped:(id)sender;

- (IBAction)addressChanged:(id)sender;
-(void)updateLocationDisplay;
@end
