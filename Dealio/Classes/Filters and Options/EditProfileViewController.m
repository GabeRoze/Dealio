//
//  EditProfileViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-22.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "EditProfileViewController.h"
#import "CalculationHelper.h"

@implementation EditProfileViewController
@synthesize registerButtonOutlet;
@synthesize navBar;
@synthesize backButton;
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.table setScrollEnabled:NO];

    // Do any additional setup after loading the view from its nib.

    [backButton setBackButtonBackgroundImage:[UIImage imageNamed:@"topnav.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];


    UILabel* label = [CalculationHelper createNavBarLabelWithTitle:@"Edit Profile"];
    [self.view addSubview:label];



    //create dictionary here from userManager

}

- (void)viewDidUnload
{
    [self setTable:nil];
    [self setRegisterButtonOutlet:nil];
    [self setRegisterButtonOutlet:nil];
    [self setBackButton:nil];
    [self setNavBar:nil];
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
            return 4;
            break;

        case 1:
            return 1;
            break;

        default:
            break;
    }
    return 0;
}



//Draws individual rows
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString* firstNameCell = @"firstNameCell";
    static NSString* lastNameCell = @"lastNameCell";
    static NSString* emailCell = @"emailCell";
    static NSString* passwordCell = @"passwordCell";
    static NSString* registerCell = @"registerCell";
    static NSString* cancelCell = @"cancelCell";



    UITableViewCell* cell;


    switch (indexPath.section) {

        case 0:

            if (indexPath.row == 0) {


                cell = [tableView dequeueReusableCellWithIdentifier:firstNameCell];

                if (cell == nil) {
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
                else {
                    cell.textLabel.text = @"WOOT!";

                }

            }

            //Last name
            else if (indexPath.row == 1) {


                cell = [tableView dequeueReusableCellWithIdentifier:lastNameCell];

                if (cell == nil) {
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
                }
                else {
                    cell.textLabel.text = @"WOOT!";

                }

            }


            //email
            else if (indexPath.row == 2) {


                cell = [tableView dequeueReusableCellWithIdentifier:emailCell];

                if (cell == nil) {
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
                }
                else {
                    cell.textLabel.text = @"WOOT!";

                }

            }

            //passwordCell
            else if (indexPath.row == 3) {


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



                    [textField addTarget:self action:@selector(fourthTextFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];


                    [textField addTarget:self action:@selector(fourthTextFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
                }
                else {
                    cell.textLabel.text = @"WOOT!";

                }

            }


            break;


        case 1:

            if (indexPath.row == 0)
            {
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:registerCell];

                    cell.textLabel.text = @"Save";
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
        case 1:

            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //remove keyboard
            for (int i = 0; i <4; i++) {
                NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
                [cell1.accessoryView resignFirstResponder];
            }


            if (indexPath.row == 0) {




                for (int i = 0; i <4; i++) {
                    NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
                    UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
                    UITextField* field = (UITextField*) cell1.accessoryView;
                    NSLog(@"%@",field.text);

                    //pass this data then save into shared manager


                }

            }


            else if (indexPath.row == 1) {
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



///////////second cell
-(void)secondTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*2)];
}

-(void) secondtextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*2)];
}


//////////third cell
-(void)thirdTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*3)];
}

-(void) thirdTextFieldDidEndEditing:(UITextField*)textField {

    [self animateView:textField distance:(44*3)];
}


//////////fourth cell
-(void)fourthTextFieldDidBeginEditing:(UITextField*)textField {

    //pass which row is editing
    [self animateView:textField distance:-(44*4)];
}

-(void) fourthTextFieldDidEndEditing:(UITextField*)textField {

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

    //NSIndexPath *a = [NSIndexPath indexPathForRow:2 inSection:0];
    //UITableViewCell* cell1 = [table cellForRowAtIndexPath:a];
    //[cell1.accessoryView becomeFirstResponder];
}

/*
 - (void) textChanged:(UITextField *)source {

 NSLog (@"test1");

 }*/



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
- (IBAction)registerButtonPressed:(id)sender {
}

- (IBAction)cancelButtonPressed:(id)sender {

    //if any text is entered, ask if user is sure they wish to exit
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)logoutButtonPressed:(id)sender {
    //create NSnotifcation
    // send logout pressed to rootview
    // rootview presents login controller

    [self dismissModalViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutButtonPressed" object:self];


}
@end
