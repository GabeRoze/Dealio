//
//  AdressTextFieldCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@interface AddressTextFieldCell : UITableViewCell
{
}

@property (strong, nonatomic) IBOutlet UITextField *addressTextField;


-(void)geoCodeAddressWithString:(NSString *)address;
- (IBAction)addressTextFieldDonePressed:(id)sender;
- (IBAction)addressTextFieldEditingDidEnd:(id)sender;

@end
