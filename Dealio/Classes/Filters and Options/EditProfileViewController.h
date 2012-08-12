//
//  EditProfileViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-22.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
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
- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)logoutButtonPressed:(id)sender;

@end
