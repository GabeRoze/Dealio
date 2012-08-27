//
//  ChangePasswordViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "GRCustomSpinnerView.h"
#import "TextFieldCell.h"

@implementation ChangePasswordViewController
@synthesize changePasswordTable;



- (void)viewDidLoad
{
    [super viewDidLoad];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_dark.png"]];
    changePasswordTable.delegate = self;
    changePasswordTable.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";


    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            CellIdentifier = @"TextFieldCellIdentifier";

            TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (!textFieldCell)
            {
                textFieldCell = [TextFieldCell new];
            }


//            textFieldCell.passwordTextField.text = @"asd";
//            [textFieldCell.textField setPlaceholder:@"Enter Current Password"];

            return textFieldCell;
//            [textField addTarget:self action:@selector(passwordEntered:) forControlEvents:UIControlEventEditingDidEndOnExit];
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            CellIdentifier = @"ChangePasswordCellIdentifier";

            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Change Password";

            return cell;
        }
        if (indexPath.row == 1)
        {
            CellIdentifier = @"CancelCellIdentifier";

            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Cancel";

            return cell;
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //perform password checking
//            [GRCustomSpinnerView.instance addSpinnerToView:self.view];
            //call register
            //on success display password successfully changed
        }
        else if (indexPath.row == 1)
        {
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}



-(void)passwordEntered:(UITextField*)source
{
    [self setCellAccessoryViewFirstResponder:[NSIndexPath indexPathForRow:1 inSection:0]];
}

-(void)newPasswordEntered: (UITextField*)source
{
    [self setCellAccessoryViewFirstResponder:[NSIndexPath indexPathForRow:2 inSection:0]];
}

-(void) passwordConfirmEntered: (UITextField*)source
{
}

-(void)setCellAccessoryViewFirstResponder:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [changePasswordTable cellForRowAtIndexPath:indexPath];
    [cell.accessoryView becomeFirstResponder];
}

- (void)viewDidUnload {
    [self setChangePasswordTable:nil];
    [super viewDidUnload];
}
@end
