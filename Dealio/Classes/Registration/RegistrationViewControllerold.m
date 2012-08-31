//
//  RegistrationViewcontroller.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-22.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "RegistrationViewControllerold.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "BorderedSpinnerView.h"

@implementation RegistrationViewControllerold
@synthesize registerButtonOutlet;
@synthesize table;
@synthesize parser;
@synthesize messageText;
@synthesize borderedSpinnerView;
@synthesize navigationBar;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        borderedSpinnerView = [[BorderedSpinnerView alloc] init];
        UILabel* label = [CalculationHelper createNavBarLabelWithTitle:@"Sign Up"];
        [self.view addSubview:label];


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
    [super viewDidLoad];
    //[self.table setScrollEnabled:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [self setRegisterButtonOutlet:nil];
    [self setRegisterButtonOutlet:nil];
    [self setNavigationBar:nil];
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
#pragma mark Table View Data Source Methods



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 5;
            break;

        case 1:
            return 2;
            break;

        default:
            break;
    }
    return 0;
}


//Draws individual rows
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* firstNameCell = @"firstNameCell";
    static NSString* lastNameCell = @"lastNameCell";
    static NSString* emailCell = @"emailCell";
    static NSString* passwordCell = @"passwordCell";
    static NSString* registerCell = @"registerCell";
    static NSString* cancelCell = @"cancelCell";

    UITableViewCell* cell;

    switch (indexPath.section)
    {
        case 0:
            if (indexPath.row == 0)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstNameCell];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CGRect frame = CGRectMake(0, 0, 240, 25);
                UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                textField.placeholder = @"First Name";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.returnKeyType = UIReturnKeyNext;

                cell.accessoryView = textField;


                [textField addTarget:self action:@selector(firstNameEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];

            }

            //Last name
            else if (indexPath.row == 1) {


                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastNameCell];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CGRect frame = CGRectMake(0, 0, 240, 25);
                UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                textField.placeholder = @"Last Name";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.returnKeyType = UIReturnKeyNext;

                cell.accessoryView = textField;


                [textField addTarget:self action:@selector(lastNameEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];

                [textField addTarget:self action:@selector(secondTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];


                [textField addTarget:self action:@selector(secondtextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];

                /*
                 }
                 else {
                 cell.textLabel.text = @"WOOT!";

                 }
                 */
            }


            //email
            else if (indexPath.row == 2) {


                //cell = [tableView dequeueReusableCellWithIdentifier:emailCell];

                // if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emailCell];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CGRect frame = CGRectMake(0, 0, 240, 25);
                UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                textField.placeholder = @"Email";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.returnKeyType = UIReturnKeyNext;
                textField.keyboardType = UIKeyboardTypeEmailAddress;

                cell.accessoryView = textField;

                [textField addTarget:self action:@selector(emailEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];

                [textField addTarget:self action:@selector(thirdTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];


                [textField addTarget:self action:@selector(thirdTextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
                /*
                 }
                 else {
                 cell.textLabel.text = @"WOOT!";

                 }
                 */
            }

            //passwordCell
            else if (indexPath.row == 3) {


                //  cell = [tableView dequeueReusableCellWithIdentifier:passwordCell];

                // if (cell == nil) {
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

                [textField addTarget:self action:@selector(fourthTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];


                [textField addTarget:self action:@selector(fourthTextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];

                /*
                 }
                 else {
                 cell.textLabel.text = @"WOOT!";

                 }
                 */
            }



            else if (indexPath.row == 4) {


                //cell = [tableView dequeueReusableCellWithIdentifier:passwordCell];

                // if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passwordCell];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CGRect frame = CGRectMake(0, 0, 240, 25);
                UITextField* textField = [[UITextField alloc] initWithFrame:frame];
                textField.placeholder = @"Confirm Password";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.returnKeyType = UIReturnKeyGo;
                [textField setSecureTextEntry:YES];
                cell.accessoryView = textField;


                [textField addTarget:self action:@selector(passwordConfirmEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];


                [textField addTarget:self action:@selector(fifthTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];


                [textField addTarget:self action:@selector(fifthTextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
                /*
                 }
                 else {
                 cell.textLabel.text = @"WOOT!";

                 }
                 */
            }

            break;


        case 1:

            if (indexPath.row == 0)
            {
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:registerCell];

                    cell.textLabel.text = @"Register!";
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                }

            }

            else if (indexPath.row == 1)
            {
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cancelCell];

                    cell.textLabel.text = @"Cancel";
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.textAlignment  = UITextAlignmentCenter;
                }

            }

            break;

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

            //second section pressed
        case 1:


            //Deselect
            [tableView deselectRowAtIndexPath:indexPath animated:YES];

            //remove keyboard
            for (int i = 0; i <5; i++) {
                NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
                [cell1.accessoryView resignFirstResponder];
            }


            //If register pressed
            if (indexPath.row == 0) {

                [self registerButtonPressed];
                //call register pressed function

                /*

                 for (int i = 0; i <5; i++) {
                 NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
                 UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
                 UITextField* field = (UITextField*) cell1.accessoryView;
                 NSLog(@"%@",field.text);

                 //pass this data then save into shared manager


                 }
                 */
            }

            //Cancel presesd
            else if (indexPath.row == 1) {
                //go back to login page
                [self dismissModalViewControllerAnimated:YES];
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

///////////second cell
-(void)secondTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*1)];
}

-(void) secondtextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*1)];
}


//////////third cell
-(void)thirdTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) thirdTextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*2)];
}


//////////fourth cell
-(void)fourthTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*3)];
}


-(void) fourthTextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*3)];
}


//////////fifth cell
-(void)fifthTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*4)];
}

-(void) fifthTextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*4)];
}


-(void) animateView: (UITextField*) textField distance:(int)distance {

    const float movementduration = 0.3f;

    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementduration];
    self.view.frame = CGRectOffset(self.view.frame, 0, distance);
    [UIView commitAnimations];

}


-(void) firstNameEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}

-(void) lastNameEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}

-(void) emailEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:3 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}

-(void) passwordEntered: (UITextField*)source {

    NSIndexPath *a = [NSIndexPath indexPathForRow:4 inSection:0];
    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    [cell1.accessoryView becomeFirstResponder];
}

-(void) passwordConfirmEntered: (UITextField*)source {

    //register button is passed
    [self registerButtonPressed];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = (NSString*)[alertView buttonTitleAtIndex:buttonIndex];

    if([title isEqualToString:@"Registration Successful!"])
    {
        NSLog(@"Registration Successful1!");
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    NSString *title = (NSString*) [alertView title];


    if([title isEqualToString:@"Registration Successful!"])
    {
        NSLog(@"Registration Successful2!");
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (IBAction)backgroundTouch:(id)sender {

    for (int i = 0; i <4; i++) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }

    for (int i = 0; i <2; i++) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:1];
        UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
        [cell1.accessoryView resignFirstResponder];
    }


}

#pragma mark -
#pragma mark Register Logic

-(void)registerButtonPressed {
    NSLog(@"registerBUttonPressed");


    //place entered data into an array of strings
    NSMutableArray* userData = [[NSMutableArray alloc] initWithCapacity:5];

    for (int i = 0; i <5; i++) {
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

    //Empty firstname check
    if ([[userData objectAtIndex:0] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your first name" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //empty lastname check
    else if ([[userData objectAtIndex:1] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your last name" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //empty email check
    else if ([[userData objectAtIndex:2] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter your email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //valid email check
    else if (![[userData objectAtIndex:2] isEqualToString:@"INVALID_ENTRY_OCCURED"] && ![CalculationHelper NSStringIsValidEmail:[userData objectAtIndex:2]]) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }

    //empty password check
    else if ([[userData objectAtIndex:3] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //empty comfirm password check
    else if ([[userData objectAtIndex:4] isEqualToString:@"INVALID_ENTRY_OCCURED"]) {
        //NSLog(@"no confirm passwor entererd");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please re-enter your password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //string length < 8 check
    else if ( ![[userData objectAtIndex:3] isEqualToString:@"INVALID_ENTRY_OCCURED"] && [(NSString*)[userData objectAtIndex:3] length] < 8 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password must be at least 8 characters long" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }



    //check for password matching
    else if ( ![(NSString*)[userData objectAtIndex:3] isEqualToString:(NSString*)[userData objectAtIndex:4]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passwords do not match" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }


    //check for password to contain numbers or characters
    else if (![CalculationHelper doesPasswordContainsLettersAndNumbers:[userData objectAtIndex:3]]) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password must contain at least one letter and one number" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    else {

        NSLog(@"wtf do the passwords match!? %d", [CalculationHelper doesPasswordContainsLettersAndNumbers:[userData objectAtIndex:3]] );

        //[self createAndDisplaySpinner];
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        messageText = @"Attempting to connect to server";

        [self performSelectorInBackground:@selector(connectToServer:) withObject:userData];

    }//end final else

}

-(void) registerSuccess {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Successful!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

}

#pragma mark -
#pragma mark Server Connectivity and XML

-(void)connectToServer:(NSArray *)userData{

    NSString* urlAsString = @"";
    NSString* firstName = [NSString stringWithFormat:@"userfirstname=%@",(NSString*)[userData objectAtIndex:0] ];
    NSString* lastName = [NSString stringWithFormat:@"&userlastname=%@",(NSString*)[userData objectAtIndex:1] ];

    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",(NSString*)[userData objectAtIndex:2] ];
    NSString* encryptedPassword = (NSString*)[userData objectAtIndex:3];
    NSString* passwordString = [NSString stringWithFormat:@"&userpw=%@",encryptedPassword ];

    urlAsString = [urlAsString stringByAppendingString:firstName];
    urlAsString = [urlAsString stringByAppendingString:lastName];
    urlAsString = [urlAsString stringByAppendingString:emailString];
    urlAsString = [urlAsString stringByAppendingString:passwordString];

    NSString* functionUrl = @"http://www.cinnux.com/userregister-func.php/";

    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlAsString];


    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

         if ([data length] > 0 && error == nil) {
             NSString* html = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
             NSLog (@"HTML = %@", html);


             //parse file
             [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];



         }
         else if ([data length] == 0 && error == nil) {
             NSLog(@"Nothing was downloaded.");
             messageText = @"Server not responding";

         }
         else if (error != nil) {
             NSLog(@"Error happened = %@", error);
             messageText = @"Error occured during login";


         }
     }];


}

-(void) serverResponseAcquired {

    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];


    if ([messageText isEqualToString:@"success"]) {

        [self registerSuccess];
    }
    else if ([messageText isEqualToString:@"exist"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account already exists, please enter another email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([messageText isEqualToString:@"fail"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration failed, please try again" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([messageText isEqualToString:@"Server not responding"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([messageText isEqualToString:@"Error occured during login"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    //NSLog(@"message text: %@", messageText);
    messageText = @"Server response acquired";

}


-(void) parseXMLFile:(NSData*)data {
    parser = [[XMLParser alloc] initXMLParser:data];
    //[self performSelectorOnMainThread:@selector(stopSpinner) withObject:nil waitUntilDone:YES];

    messageText = [parser.registerResult objectForKey:@"registerresult"];
    [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];


}





#pragma mark - Spinner (defunct)

-(void) createAndDisplaySpinner {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height = [UIScreen mainScreen].bounds.size.height;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(width/2.0,50.0)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}


-(void) stopSpinner {


    [spinner stopAnimating];
    [spinner removeFromSuperview];

}


@end
