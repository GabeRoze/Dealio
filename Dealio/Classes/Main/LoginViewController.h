//
//  LoginViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-14.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
@class XMLParser;
@class BorderedSpinnerView;


@interface LoginViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIActivityIndicatorView* spinner;
}


@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) XMLParser* parser;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) RegistrationViewController* registrationViewController;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;

-(IBAction)emailFieldDoneEditing:(id)sender;
-(IBAction)loginDone:(id)sender;
-(IBAction)signUpButtonPressed:(id)sender;
-(IBAction)backgroundTap:(id)sender;


-(void) emailEntered: (UITextField*)source;
-(void) passwordEntered: (UITextField*)source;
-(void) animateView: (UITextField*) textField distance:(int)distance;
-(void)loginSuccess;
-(void) attemptLogin;
-(void)parseXMLFile:(NSData*)data;
-(void) stopSpinner;
-(void) createAndDisplaySpinner;
-(void) connectToServer:(NSArray*)userData;

@end

