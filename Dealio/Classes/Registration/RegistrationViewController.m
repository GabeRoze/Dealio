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
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

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
        textFieldCell.cellTextField.secureTextEntry = YES;
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
        [textFieldCell.cellTextField addTarget:self action:@selector(whatDoesDealioBeganEditing:) forControlEvents:UIControlEventEditingDidBegin];

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
        if (pickerDisplayCell.timeLabel.text.length < 1)
        {
            pickerDisplayCell.timeLabel.text = @"Prefer not to say";
            age = 0;
        }

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
        if (pickerDisplayCell.timeLabel.text.length < 1)
        {
            pickerDisplayCell.timeLabel.text = @"Prefer not to say";
            ethnicity = 0;
        }

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

        if (pickerDisplayCell.timeLabel.text.length < 1)
        {
            pickerDisplayCell.timeLabel.text = @"Prefer not to say";
            income = 0;
        }

        return pickerDisplayCell;
    }
    else if ((indexPath.row == 9 && !optionalInfoPresent) || (indexPath.row == 14 && optionalInfoPresent))
    {
        cellID = @"CancelButtonCellIdentifier";

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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

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
    else if ((indexPath.row == 8 && !optionalInfoPresent) || (indexPath.row == 13 && optionalInfoPresent))
    {
        NSLog(@"SUBMIT");
    }
    else if ((indexPath.row == 9 && !optionalInfoPresent) || (indexPath.row == 14 && optionalInfoPresent))
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else if (indexPath.row == 8 && optionalInfoPresent)
    {
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            PickerDisplayCell *pickerDisplayCell = (PickerDisplayCell *)[tableView cellForRowAtIndexPath:indexPath];
            pickerDisplayCell.timeLabel.text = selectedValue;
            age = selectedIndex;
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {

        };
        NSArray *ages = [NSArray arrayWithObjects:@"Prefer not to say", @"Under 10", @"10 - 19", @"20 - 29",@"30 - 39", @"40 - 49", @"50 - 59", @"Over 60", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select Your Age" rows:ages initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    }
    else if (indexPath.row == 9 && optionalInfoPresent)
    {
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            PickerDisplayCell *pickerDisplayCell = (PickerDisplayCell *)[tableView cellForRowAtIndexPath:indexPath];
            pickerDisplayCell.timeLabel.text = selectedValue    ;
            ethnicity = selectedIndex;
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {

        };
        NSArray *ethnicities = [NSArray arrayWithObjects:@"Prefer not to say", @"Caucasian", @"African American/Black", @"Hispanic/Latino", @"Asian", @"Middle Eastern", @"Pacific Islander", @"Native American/Alaskan", @"Other", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select Your Ethnicity" rows:ethnicities initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    }
    else if (indexPath.row == 10 && optionalInfoPresent)
    {
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            PickerDisplayCell *pickerDisplayCell = (PickerDisplayCell *)[tableView cellForRowAtIndexPath:indexPath];
            pickerDisplayCell.timeLabel.text = selectedValue;
            income = selectedIndex;
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {

        };
        NSArray *incomes = [NSArray arrayWithObjects:@"Prefer not to say", @"Under $10,000", @"$10,000 - $25,000", @"$25,000 - $40,000", @"$40,000 - $60,000", @"$60,000 - $85,000", @"Over $85,000" ,nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select Your Income" rows:incomes initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    }
}

-(void)whatDoesDealioBeganEditing:(id)sender
{
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)submit
{
    //verify all cell data
    //submit
}
@end
