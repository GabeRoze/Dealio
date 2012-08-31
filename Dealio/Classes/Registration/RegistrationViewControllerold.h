//
//
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-22.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMLParser;
@class BorderedSpinnerView;

@interface RegistrationViewControllerold : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate> {
      UIActivityIndicatorView* spinner;
}



@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)backgroundTouch:(id)sender;

//2nd
-(void)secondTextFieldDidBeginEditing:(UITextField*)textField;
-(void) secondtextFieldDidEndEditing:(UITextField*)textField;
//3rd cell
-(void)thirdTextFieldDidBeginEditing:(UITextField*)textField;
-(void) thirdTextFieldDidEndEditing:(UITextField*)textField;
//4th cell
-(void)fourthTextFieldDidBeginEditing:(UITextField*)textField;
-(void) fourthTextFieldDidEndEditing:(UITextField*)textField ;

-(void) animateView: (UITextField*) textField distance:(int)distance;

-(void) firstNameEntered: (UITextField*)source;
-(void) lastNameEntered: (UITextField*)source;
-(void) emailEntered: (UITextField*)source;
-(void) passwordEntered: (UITextField*)source;

@property (weak, nonatomic) IBOutlet UIButton *registerButtonOutlet;

@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;

-(void) registerButtonPressed;

-(void) createAndDisplaySpinner;
-(void) stopSpinner;
-(void) connectToServer:(NSArray*)userData;
-(void)parseXMLFile:(NSData*)data;
-(void) attemptRegister;
-(void) registerSuccess;

@end
