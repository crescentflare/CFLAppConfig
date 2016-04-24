//
//  CFLAppConfigEditTable.m
//  CFLAppConfig Pod
//

//Imports
#import "CFLAppConfigEditTable.h"
#import "CFLAppConfigEditTableCell.h"
#import "CFLAppConfigEditTableValue.h"
#import "CFLAppConfigEditActionCell.h"
#import "CFLAppConfigEditTextCell.h"
#import "CFLAppConfigEditSliderCell.h"
#import "CFLAppConfigEditLoadingCell.h"
#import "CFLAppConfigEditSectionCell.h"

//Internal interface definition
@interface CFLAppConfigEditTable ()

@property (nonatomic, strong) NSMutableArray *tableValues;
@property (nonatomic, strong) UITableView *tableView;

@end

//Interface implementation
@implementation CFLAppConfigEditTable

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Set up table view
        self.tableView = [UITableView new];
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];
        [self addSubview:self.tableView];
        
        //Set table view properties
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //Show loading indicator by default
        self.tableValues = [NSMutableArray new];
        [self.tableValues addObject:[CFLAppConfigEditTableValue valueForLoading:NSLocalizedString(@"Loading configurations...", nil)]];
    }
    return self;
}


#pragma mark Layout

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark Implementation

- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName
{
    [self setConfigurationSettings:configurationSettings forConfig:configName withModel:nil];
}

- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName withModel:(CFLAppConfigBaseModel *)model
{
    //Add editable fields
    BOOL configSectionAdded = NO;
    NSDictionary *modelStructure = nil;
    NSDictionary *modelValueTypes = nil;
    if (model)
    {
        modelValueTypes = [model obtainValueTypes];
        modelStructure = [model.class modelStructure];
    }
    self.tableValues = [NSMutableArray new];
    if ([[configurationSettings allKeys] count] > 0)
    {
        for (NSString *key in configurationSettings)
        {
            if ([key isEqualToString:@"name"])
            {
                continue;
            }
            if (!configSectionAdded)
            {
                [self.tableValues addObject:[CFLAppConfigEditTableValue valueForSection:configName]];
                configSectionAdded = YES;
            }
            NSObject *value = [configurationSettings valueForKey:key];
            if (modelValueTypes)
            {
                if (modelValueTypes[key] && [modelValueTypes[key] isEqualToString:@"BOOL"] && [value isKindOfClass:NSNumber.class])
                {
                    [self.tableValues addObject:[CFLAppConfigEditTableValue valueForSlider:key andSwitchedOn:[((NSNumber *)value) boolValue]]];
                    continue;
                }
            }
            if ([value isKindOfClass:NSNumber.class])
            {
                [self.tableValues addObject:[CFLAppConfigEditTableValue valueForEditText:key andValue:[((NSNumber *)value) stringValue] numberOnly:YES]];
            }
            else
            {
                [self.tableValues addObject:[CFLAppConfigEditTableValue valueForEditText:key andValue:value numberOnly:NO]];
            }
        }
    }
    
    //Add actions and reload table
    [self.tableValues addObject:[CFLAppConfigEditTableValue valueForSection:NSLocalizedString(@"Actions", nil)]];
    [self.tableValues addObject:[CFLAppConfigEditTableValue valueForAction:CFLAppConfigEditTableValueActionSave andText:NSLocalizedString(@"Apply changes", nil)]];
    [self.tableValues addObject:[CFLAppConfigEditTableValue valueForAction:CFLAppConfigEditTableValueActionCancel andText:NSLocalizedString(@"Cancel", nil)]];
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create cell (if needed)
    CFLAppConfigEditTableValue *tableValue = (CFLAppConfigEditTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    CFLAppConfigEditTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[tableValue cellIdentifier]];
    if (!cell)
    {
        cell = [CFLAppConfigEditTableCell new];
    }
    
    //Set up a loader list cell
    if (tableValue.type == CFLAppConfigEditTableValueTypeLoading)
    {
        //Create view
        CFLAppConfigEditLoadingCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditLoadingCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditLoadingCell *)cell.cellView;
        }
        
        //Supply data
        cellView.loadingText = tableValue.labelString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }
    
    //Set up an action cell
    if (tableValue.type == CFLAppConfigEditTableValueTypeAction)
    {
        //Create view
        CFLAppConfigEditActionCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditActionCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditActionCell *)cell.cellView;
        }
        
        //Supply data
        cellView.labelText = tableValue.labelString;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }
    
    //Set up an edit text cell
    if (tableValue.type == CFLAppConfigEditTableValueTypeEditText)
    {
        //Create view
        CFLAppConfigEditTextCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditTextCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditTextCell *)cell.cellView;
        }
        
        //Supply data
        cellView.labelText = tableValue.configSetting;
        cellView.editedText = tableValue.labelString;
        cellView.numbersOnly = tableValue.limitUsage;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Set up a slider cell
    if (tableValue.type == CFLAppConfigEditTableValueTypeSlider)
    {
        //Create view
        CFLAppConfigEditSliderCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditSliderCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditSliderCell *)cell.cellView;
        }
        
        //Supply data
        cellView.labelText = tableValue.configSetting;
        cellView.on = tableValue.booleanValue;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Set up a selection cell (for enums)
    if (tableValue.type == CFLAppConfigEditTableValueTypeSelection)
    {
        //Create view
        CFLAppConfigEditActionCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditActionCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditActionCell *)cell.cellView;
        }
        
        //Supply data
        cellView.labelText = [NSString stringWithFormat:@"%@: %@", tableValue.configSetting, tableValue.labelString];

        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Set up a section cell
    if (tableValue.type == CFLAppConfigEditTableValueTypeSection)
    {
        //Create view
        CFLAppConfigEditSectionCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigEditSectionCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigEditSectionCell *)cell.cellView;
        }
        
        //Supply data
        cellView.sectionText = [tableValue.labelString uppercaseString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Return result
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigEditTableValue *tableValue = (CFLAppConfigEditTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    return tableValue.type == CFLAppConfigEditTableValueTypeAction;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigEditTableCell *cell = (CFLAppConfigEditTableCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    if (cell && cell.cellView)
    {
        return [cell.cellView sizeThatFits:self.frame.size].height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigEditTableValue *tableValue = (CFLAppConfigEditTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    if (tableValue.type == CFLAppConfigEditTableValueTypeAction && self.delegate)
    {
        switch (tableValue.action)
        {
            case CFLAppConfigEditTableValueActionSave:
                [self.delegate saveConfig];
                break;
            case CFLAppConfigEditTableValueActionCancel:
                [self.delegate cancelEditing];
                break;
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
