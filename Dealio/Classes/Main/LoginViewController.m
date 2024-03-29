//
//  LoginViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-14.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "LoginViewController.h"
#import "TheRestaurantAppDelegate.h"
#import "XMLParser.h"
#import "MD5Encrypter.h"
#import "CalculationHelper.h"
#import "BorderedSpinnerView.h"
#import "DealioService.h"
#import "GRCustomSpinnerView.h"
#import "Models.h"
#import "AlertHelper.h"

@implementation LoginViewController
@synthesize emailField;
@synthesize passwordField;
@synthesize registrationViewController;
@synthesize table;
@synthesize parser;
@synthesize messageText;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        registrationViewController = [[RegistrationViewController alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordTapped:)];
    [forgotPasswordLabel addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewDidUnload
{
    [self setEmailField:nil];
    [self setPasswordField:nil];
    [self setTable:nil];
    [super viewDidUnload];
}


#pragma mark -
#pragma mark Login Logic
//Called after go is tapped from password field or login is pressed
-(IBAction)loginDone:(id)sender
{
    [self attemptLogin];
}

-(void) attemptLogin
{
    //Hide keyboard
    for (int i = 0; i <2; i++)
    {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }

    //place entered data into an array of strings
    NSMutableArray* userData = [[NSMutableArray alloc] initWithCapacity:5];

    for (int i = 0; i <2; i++)
    {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        UITextField* field = (UITextField*) cell1.accessoryView;

        //validate entries
        if (field.text == NULL || [field.text isEqualToString:@""])
        {
            [userData insertObject:@"INVALID_ENTRY_OCCURED" atIndex:i];
        }
        else
        {
            [userData insertObject:field.text atIndex:i];
        }
    }

    if ([[userData objectAtIndex:0] isEqualToString:@"INVALID_ENTRY_OCCURED"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([[userData objectAtIndex:1] isEqualToString:@"INVALID_ENTRY_OCCURED"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //show spinner
        [GRCustomSpinnerView.instance addSpinnerToView:self.view];
        messageText = @"Attempting to connect to server";

        [DealioService loginWithEmail:[userData objectAtIndex:0] password:[userData objectAtIndex:1] onSuccess:^(NSData *data){

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                parser = [[XMLParser alloc] initXMLParser:data];
                messageText = [parser.userFunction objectForKey:@"message"];
                UserData.instance.firstName = [parser.userFunction objectForKey:@"userfirstname"];
                UserData.instance.lastName = [parser.userFunction objectForKey:@"userlastname"];
                UserData.instance.email = [userData objectAtIndex:0];

                dispatch_async( dispatch_get_main_queue(), ^{
                    [GRCustomSpinnerView.instance stopSpinner];
                    [self serverResponseAcquired];
                });
            });
        }
                            onFailure:^{
                                //todo display uifailure alert
                            }];
    }
}

-(void)loginSuccess
{
    [NSUserDefaults.standardUserDefaults setObject:UserData.instance.email forKey:@"lastUserLoggedIn"];

    NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    UITextField* field = (UITextField*) cell1.accessoryView;

    //set second cell to null
    a = [NSIndexPath indexPathForRow:1 inSection:0];
    cell1 = [table cellForRowAtIndexPath:a];
    field = (UITextField*) cell1.accessoryView;
    field.text = @"";

    TheRestaurantAppDelegate *appDelegate = (TheRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate loginSuccess];
}

-(IBAction)signUpButtonPressed:(id)sender
{
    registrationViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:registrationViewController animated:YES];
}

-(void) serverResponseAcquired
{
    if ([messageText isEqualToString:@"success"])
    {
        [self loginSuccess];
    }
    else if ([messageText isEqualToString:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid username and password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([messageText isEqualToString:@"Server not responding"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([messageText isEqualToString:@"Error occured during login"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    messageText = @"Server response acquired";
}

#pragma mark - Table View Data Source Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* emailCell = @"emailCell";
    static NSString* passwordCell = @"passwordCell";

    UITableViewCell* cell;

    switch (indexPath.section)
    {
        case 0:
            //email
            if (indexPath.row == 0)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:emailCell];

                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emailCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    CGRect frame = CGRectMake(0, 0, 240, 25);
                    UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                    textField.placeholder = @"Email";
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    textField.keyboardType = UIKeyboardTypeEmailAddress;
                    textField.returnKeyType = UIReturnKeyNext;
                    cell.accessoryView = textField;

                    //Create event triggers
                    [textField addTarget:self action:@selector(emailEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [textField addTarget:self action:@selector(firstTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
                    [textField addTarget:self action:@selector(firstTextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];

                    if ([NSUserDefaults.standardUserDefaults stringForKey:@"lastUserLoggedIn"])
                    {
                        textField.text = [NSUserDefaults.standardUserDefaults stringForKey:@"lastUserLoggedIn"];
                    }
                }
                else
                {
                    cell.textLabel.text = @"Error Occured!";
                }
            }
            else if (indexPath.row == 1)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:passwordCell];

                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passwordCell];

                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    CGRect frame = CGRectMake(0, 0, 240, 25);
                    UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                    textField.placeholder = @"Password";
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    textField.returnKeyType = UIReturnKeyGo;
                    [textField setSecureTextEntry:YES];

                    cell.accessoryView = textField;

                    [textField addTarget:self action:@selector(passwordEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [textField addTarget:self action:@selector(secondTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
                    [textField addTarget:self action:@selector(secondtextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
                }
                else
                {
                    cell.textLabel.text = @"Error Occured!";
                }
            }
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            break;
        case 1:
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //remove keyboard
            for (int i = 0; i <2; i++) {
                NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
                [cell1.accessoryView resignFirstResponder];
            }
            break;
        default:
            break;
    }
}

//Set cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark -
#pragma mark Cell Action Responders
//Selects password field as first responder after selecting go
-(IBAction)emailFieldDoneEditing:(id)sender
{
    //Selects password field when pressing next
    [passwordField becomeFirstResponder];
}

//Hide keyboard when backgrond is tapped
-(IBAction)backgroundTap:(id)sender
{
    for (int i = 0; i <2; i++)
    {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }
}

///////////first cell
-(void)firstTextFieldDidBeginEditing:(UITextField*)textField
{
    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) firstTextFieldDidEndEditing:(UITextField*)textField
{
    [self animateView:textField distance:(44*2)];
}

///////////second cell
-(void)secondTextFieldDidBeginEditing:(UITextField*)textField
{
    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) secondtextFieldDidEndEditing:(UITextField*)textField
{
    [self animateView:textField distance:(44*2)];
}

-(void) animateView: (UITextField*) textField distance:(int)distance
{
    const float movementduration = 0.3f;

    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementduration];
    self.view.frame = CGRectOffset(self.view.frame, 0, distance);
    [UIView commitAnimations];
}

-(void) emailEntered: (UITextField*)source
{
    NSIndexPath *a = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}

-(void) passwordEntered: (UITextField*)source
{
    NSIndexPath *a = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView resignFirstResponder];
    [self attemptLogin];
}

#pragma mark Forgot Password
-(IBAction)forgotPasswordTapped:(id)sender
{
    UITableViewCell *tableViewCell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField = (UITextField *)tableViewCell.accessoryView;
    NSString *email = textField.text;

    if (email.length > 0)
    {
        [GRCustomSpinnerView.instance addSpinnerToView:self.view];

        [DealioService forgotPassword:email onSuccess:^(NSData *data){

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                dispatch_async( dispatch_get_main_queue(), ^{
                    parser = [[XMLParser alloc] initXMLParser:data];
                    NSString *message = [parser.userFunction objectForKey:@"message"];
                    [GRCustomSpinnerView.instance stopSpinner];

                    if ([message isEqualToString:@"emailsuccess"])
                    {
                        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Email Sent" withMessage:@"Check your email for instructions on how to reset your password" andAction:nil];
                    }
                    else if ([messageText isEqualToString:@"noaccountfound"])
                    {
                        [AlertHelper displayAlertWithOKButtonUsingTitle:@"No Account Found" withMessage:@"Please enter a valid email address or sign up for an account." andAction:nil];
                    }
                    else if ([message isEqualToString:@"noaccountfound"])
                    {
                        [AlertHelper displayAlertWithOKButtonUsingTitle:@"No Account Found" withMessage:@"Please enter a valid email address or sign up for an account." andAction:nil];
                    }
                    else
                    {
                        [DealioService webConnectionFailed];
                    }
                });
            });
        } andFailure:nil];
    }
    else
    {
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Enter Your Email" withMessage:@"You will be emailed a confirmation to change your password" andAction:^{
            [textField becomeFirstResponder];
        }];
    }
}

@end