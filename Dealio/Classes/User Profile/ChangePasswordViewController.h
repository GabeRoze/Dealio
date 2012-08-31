//
//  ChangePasswordViewController.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
{
    IBOutlet UITextField *currentPasswordTextField;
    IBOutlet UITextField *newPasswordTextField;
    IBOutlet UITextField *confirmNewPasswordTextfield;
}

- (IBAction)cancelTapped:(id)sender;
- (IBAction)changePasswordOKTapped:(id)sender;
@end
