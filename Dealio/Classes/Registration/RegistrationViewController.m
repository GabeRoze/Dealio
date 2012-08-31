//
//  RegistrationViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <sys/ucred.h>
#import "RegistrationViewController.h"
#import "TableHeaderCell.h"
#import "SideBySideTextFieldCell.h"
#import "TextFieldCell.h"
#import "TableFooterCell.h"
#import "MaleFemaleSelectionCell.h"
#import "TOSCell.h"
#import "ButtonCell.h"
#import "PickerDisplayCell.h"
#import "ActionSheetPicker.h"

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    optionalInfoPresent = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (optionalInfoPresent)
        return 15;
    else
        return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableCellIdentifier";

    if (indexPath.row == 0)
    {
        cellID = @"TableHeaderCellIdentifier";

        TableHeaderCell *tableHeaderCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!tableHeaderCell)
        {
            tableHeaderCell = [TableHeaderCell new];
        }

        tableHeaderCell.headerLabel.text = @"Basic Info";
        tableHeaderCell.headerBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
        tableHeaderCell.headerLeftImage.image = [UIImage imageNamed:@"button_profile_s.png"];


        return tableHeaderCell;
    }
    else if (indexPath.row == 1)
    {
        cellID = @"SideBySideTextFieldCellIdentifier";

        SideBySideTextFieldCell *sidebySideTextFieldCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!sidebySideTextFieldCell)
        {
            sidebySideTextFieldCell = [SideBySideTextFieldCell new];
        }

        [sidebySideTextFieldCell.leftTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [sidebySideTextFieldCell.rightTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        return sidebySideTextFieldCell;
    }
    else if (indexPath.row == 2)
    {
        cellID = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        textFieldCell.backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
        textFieldCell.cellTextField.placeholder = @"Email Address";
        [textFieldCell.cellTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        return textFieldCell;
    }
    else if (indexPath.row == 3)
    {
        cellID = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        textFieldCell.backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
        textFieldCell.cellTextField.placeholder = @"Password";
        [textFieldCell.cellTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        return textFieldCell;
    }
    else if (indexPath.row == 4)
    {
        cellID = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_teal_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 5)
    {
        cellID = @"TableHeaderCellIdentifier";

        TableHeaderCell *tableHeaderCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!tableHeaderCell)
        {
            tableHeaderCell = [TableHeaderCell new];
        }

        tableHeaderCell.headerLabel.text = @"Optional Info";
        tableHeaderCell.headerBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
        tableHeaderCell.headerLeftImage.image = [UIImage imageNamed:@"button_info.png"];


        return tableHeaderCell;
    }
    else if (indexPath.row == 6 && !optionalInfoPresent || (indexPath.row == 11 && optionalInfoPresent))
    {
        cellID = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_tan_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 6 && optionalInfoPresent)
    {
        cellID = @"MaleFemaleSelectionCellIdentifier";

        MaleFemaleSelectionCell *maleFemaleSelectionCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!maleFemaleSelectionCell)
        {
            maleFemaleSelectionCell =  [MaleFemaleSelectionCell new];
        }

        return maleFemaleSelectionCell;
    }
    else if (indexPath.row == 7 && optionalInfoPresent)
    {
        cellID = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        textFieldCell.backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
        textFieldCell.cellTextField.placeholder = @"What does a DEAL mean to you?";
//        [textFieldCell.cellTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

        return textFieldCell;
    }
    else if ((indexPath.row == 7 && !optionalInfoPresent) || (indexPath.row == 12 && optionalInfoPresent))
    {
        cellID = @"TOSCellIdentifier";

        TOSCell *tosCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!tosCell)
        {
            tosCell = [TOSCell new];
        }

        return tosCell;
    }
    else if ((indexPath.row == 8 && !optionalInfoPresent) || (indexPath.row == 13 && optionalInfoPresent))
    {
        cellID = @"ButtonCellIdentifier";

        ButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!buttonCell)
        {
            buttonCell = [ButtonCell new];
        }

        return buttonCell;
    }
    else if (indexPath.row == 8 && optionalInfoPresent)
    {
        cellID = @"PickerDisplayCell";

        PickerDisplayCell *pickerDisplayCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!pickerDisplayCell)
        {
            pickerDisplayCell = [PickerDisplayCell new];
        }

        pickerDisplayCell.descriptionLabel.text = @"Age";

        return pickerDisplayCell;
    }
    else if (indexPath.row == 9 && optionalInfoPresent)
    {
        cellID = @"PickerDisplayCell";

        PickerDisplayCell *pickerDisplayCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!pickerDisplayCell)
        {
            pickerDisplayCell = [PickerDisplayCell new];
        }

        pickerDisplayCell.descriptionLabel.text = @"Ethnicity";

        return pickerDisplayCell;
    }
    else if (indexPath.row == 10 && optionalInfoPresent)
    {
        cellID = @"PickerDisplayCell";

        PickerDisplayCell *pickerDisplayCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!pickerDisplayCell)
        {
            pickerDisplayCell = [PickerDisplayCell new];
        }

        pickerDisplayCell.descriptionLabel.text = @"Income";

        return pickerDisplayCell;
    }
    else if ((indexPath.row == 9 && !optionalInfoPresent) || (indexPath.row == 14 && optionalInfoPresent))
    {
        cellID = @"ButtonCellIdentifier";

        ButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:cellID];

        if (!buttonCell)
        {
            buttonCell = [ButtonCell new];
        }

        buttonCell.buttonLabel.text = @"Cancel";

        return buttonCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4 || (indexPath.row == 6 && !optionalInfoPresent) || indexPath.row == 11 && optionalInfoPresent)
    {
        return 20;
    }
    else if (indexPath.row == 6 && optionalInfoPresent)
    {
        return 88;
    }
    else
    {
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 5 && optionalInfoPresent)
    {
        optionalInfoPresent = NO;
        [tableView reloadData];
    }
    else if (indexPath.row == 5 && !optionalInfoPresent)
    {
        optionalInfoPresent = YES;
        [tableView reloadData];
    }
    else if ((indexPath.row == 9 && !optionalInfoPresent) || (indexPath.row == 14 && optionalInfoPresent))
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}
@end
