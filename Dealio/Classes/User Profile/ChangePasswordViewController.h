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
    IBOutlet UIImageView *backgroundImage;
}
@property (strong, nonatomic) IBOutlet UITextField *currentPasswordTextField;
- (IBAction)currentPasswordEntered:(id)sender;
- (IBAction)newPasswordEntered:(id)sender;
- (IBAction)confirmNewPasswordEntered:(id)sender;


- (IBAction)cancelTapped:(id)sender;
- (IBAction)okTapped:(id)sender;
@end
