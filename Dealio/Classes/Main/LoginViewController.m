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
#import "UserManager.h"
#import "CalculationHelper.h"
#import "BorderedSpinnerView.h"

@implementation LoginViewController
@synthesize emailField;
@synthesize passwordField;
@synthesize registrationViewController;
@synthesize table;
@synthesize parser;
@synthesize messageText;
@synthesize borderedSpinnerView;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        registrationViewController = [[RegistrationViewController alloc] init];
        borderedSpinnerView = [[BorderedSpinnerView alloc] init];

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidLoad
{
    /*
     //Hides self
     [self.parentViewController.view setHidden:YES];
     */

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    //NSLog(@"loginDidUnload");
    [self setEmailField:nil];
    [self setPasswordField:nil];
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Login Logic

//Called after go is tapped from password field or login is pressed
-(IBAction)loginDone:(id)sender{
    [self attemptLogin];
}

-(void) attemptLogin
{
    //Hide keyboard
    for (int i = 0; i <2; i++) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }

    //place entered data into an array of strings
    NSMutableArray* userData = [[NSMutableArray alloc] initWithCapacity:5];

    for (int i = 0; i <2; i++) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        UITextField* field = (UITextField*) cell1.accessoryView;
        //NSLog(@"%@",field.text);

        //validate entries
        if (field.text == NULL || [field.text isEqualToString:@""]) {
            [userData insertObject:@"INVALID_ENTRY_OCCURED" atIndex:i];
        }
        else {
            [userData insertObject:field.text atIndex:i];
        }
    }


    if ([[userData objectAtIndex:0] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([[userData objectAtIndex:1] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    else {
        //show spinner
        //[self createAndDisplaySpinner];
        //[self presentModalViewController:borderedSpinnerView animated:NO];
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];


        //set message text
        messageText = @"Attempting to connect to server";
        //Create a background thread to connect to the server
        [self performSelectorInBackground:@selector(connectToServer:) withObject:userData];



    }//end final else

}

-(void)loginSuccess{
    /*
     call loginSucess in app delegate
     set userManager email
     clear password field
     get info from first cell
     */
    NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    UITextField* field = (UITextField*) cell1.accessoryView;


    [UserManager sharedManager].email = (NSString*)field.text;
    //NSLog(@"shared maanger email!:: %@", [UserManager sharedManager].email);

    //set second cell to null
    a = [NSIndexPath indexPathForRow:1 inSection:0];
    cell1 = [table cellForRowAtIndexPath:a];
    field = (UITextField*) cell1.accessoryView;
    field.text = @"";

    TheRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate loginSuccess];
}

-(IBAction)signUpButtonPressed:(id)sender
{
    registrationViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:registrationViewController animated:YES];
}


#pragma mark -
#pragma mark Server Connectivity and XML

-(void) connectToServer:(NSArray*)userData {




    // Setup URLRequest data

    NSString* urlAsString = @"";
    NSString* emailString = [NSString stringWithFormat:@"useremail=%@",(NSString*)[userData objectAtIndex:0] ];
    NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
    NSString* passwordString = [NSString stringWithFormat:@"&userpw=%@",encryptedPassword ];
    urlAsString = [urlAsString stringByAppendingString:emailString];
    urlAsString = [urlAsString stringByAppendingString:passwordString];

    NSString* functionUrl = @"http://www.cinnux.com/userlogin-func.php/";



    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlAsString];



    NSOperationQueue *queue = [[NSOperationQueue alloc] init];


    //NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];




    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

         if ([data length] > 0 && error == nil) {
             NSString* html = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
             //NSLog (@"HTML = %@", html);


             //parse file
             [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];



         }
         else if ([data length] == 0 && error == nil) {
             //NSLog(@"Nothing was downloaded.");
             messageText = @"Server not responding";
         }
         else if (error != nil) {
             //NSLog(@"Error happened = %@", error);
             messageText = @"Error occured during login";


         }
     }];

}


-(void) serverResponseAcquired {

    //[self stopSpinner];
    //[self dismissModalViewControllerAnimated:NO];
    [borderedSpinnerView.view removeFromSuperview];


    if ([messageText isEqualToString:@"success"]) {

        [self loginSuccess];
    }
    else if ([messageText isEqualToString:@"fail"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid username and password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self stopSpinner];
    }
    else if ([messageText isEqualToString:@"Server not responding"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self stopSpinner];
    }
    else if ([messageText isEqualToString:@"Error occured during login"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self stopSpinner];
    }

    //NSLog(@"message text: %@", messageText);
    messageText = @"Server response acquired";

}


-(void) parseXMLFile:(NSData*)data {
    parser = [[XMLParser alloc] initXMLParser:data];
    //[self performSelectorOnMainThread:@selector(stopSpinner) withObject:nil waitUntilDone:YES];

    //NSLog(@"firstname %@",[parser.loginResult objectForKey:@"userfirstname"]);
    //NSLog(@"lastname %@",[parser.loginResult objectForKey:@"userlastname"]);
    messageText = [parser.loginResult objectForKey:@"message"];
    [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];


}


#pragma mark - Spinner (defunct)

-(void) createAndDisplaySpinner {

    //NSLog(@"spiner displayed");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(width/2.0,height - 110.0)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void) stopSpinner {

    //NSLog(@"spinner hidden");

    [spinner stopAnimating];
    [spinner removeFromSuperview];

}




#pragma mark -
#pragma mark Table View Data Source Methods


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 2;
            break;


        default:
            break;
    }
    return 0;
}

//Draws individual rows
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString* emailCell = @"emailCell";
    static NSString* passwordCell = @"passwordCell";

    UITableViewCell* cell;


    switch (indexPath.section) {

        case 0:

            //email
            if (indexPath.row == 0) {

                cell = [tableView dequeueReusableCellWithIdentifier:emailCell];

                if (cell == nil) {

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

                }
                else {
                    cell.textLabel.text = @"Error Occured!";
                }

            }

            //password
            else if (indexPath.row == 1) {


                cell = [tableView dequeueReusableCellWithIdentifier:passwordCell];

                if (cell == nil) {
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
                else {
                    cell.textLabel.text = @"Error Occured!";

                }

            }

        default:
            break;
    }

    return cell;
}



/*
 //specifes row selection
 -(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {


 return indexPath;

 }
 */


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}



#pragma mark -
#pragma mark Cell Action Responders


//Selects password field as first responder after selecting go
-(IBAction)emailFieldDoneEditing:(id)sender{

    //Selects password field when pressing next
    [passwordField becomeFirstResponder];
}

//Hide keyboard when backgrond is tapped
-(IBAction)backgroundTap:(id)sender{

    for (int i = 0; i <2; i++) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }

}


///////////first cell
-(void)firstTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) firstTextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*2)];
}


///////////second cell
-(void)secondTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) secondtextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*2)];
}



-(void) animateView: (UITextField*) textField distance:(int)distance {

    const float movementduration = 0.3f;

    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementduration];
    self.view.frame = CGRectOffset(self.view.frame, 0, distance);
    [UIView commitAnimations];

}


-(void) emailEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}


-(void) passwordEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView resignFirstResponder];
    [self attemptLogin];
}




@end
