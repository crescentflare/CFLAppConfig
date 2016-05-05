//
//  CFLAppConfigManageTable.m
//  CFLAppConfig Pod
//

//Imports
#import "CFLAppConfigManageTable.h"
#import "CFLAppConfigManageTableCell.h"
#import "CFLAppConfigManageTableValue.h"
#import "CFLAppConfigManageInfoCell.h"
#import "CFLAppConfigManageItemCell.h"
#import "CFLAppConfigManageLoadingCell.h"
#import "CFLAppConfigManageSectionCell.h"
#import "CFLAppConfigStorage.h"

//Internal interface definition
@interface CFLAppConfigManageTable ()

@property (nonatomic, strong) NSMutableArray *tableValues;
@property (nonatomic, strong) UITableView *tableView;

@end

//Interface implementation
@implementation CFLAppConfigManageTable

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
        [self.tableValues addObject:[CFLAppConfigManageTableValue valueForLoading:NSLocalizedString(@"Loading configurations...", nil)]];
    }
    return self;
}


#pragma mark Layout

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark Implementation

- (void)setConfigurations:(NSArray *)configurations lastSelected:(NSString *)lastSelectedConfig
{
    //Table values list
    self.tableValues = [NSMutableArray new];
    
    //Add last selected config
    BOOL foundLastSelected = NO;
    [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForSection:NSLocalizedString(@"Last selected", nil)]];
    if (lastSelectedConfig)
    {
        for (NSString *configuration in configurations)
        {
            if ([configuration isEqualToString:lastSelectedConfig])
            {
                NSString *label = lastSelectedConfig;
                if ([[CFLAppConfigStorage sharedStorage] isConfigOverride:label])
                {
                    label = [NSString stringWithFormat:@"%@ *", label];
                }
                [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForConfig:lastSelectedConfig andText:label]];
                foundLastSelected = YES;
                break;
            }
        }
    }
    if (!foundLastSelected)
    {
        [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForConfig:@"" andText:NSLocalizedString(@"None", nil)]];
    }

    //Add predefined configurations (if present)
    if ([configurations count] > 0)
    {
        [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForSection:NSLocalizedString(@"Predefined configurations", nil)]];
        for (NSString *configuration in configurations)
        {
            NSString *label = configuration;
            if ([[CFLAppConfigStorage sharedStorage] isConfigOverride:label])
            {
                label = [NSString stringWithFormat:@"%@ *", label];
            }
            [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForConfig:configuration andText:label]];
        }
    }
    
    //Add build information
    [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForSection:NSLocalizedString(@"Build information", nil)]];
    [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForInfo:[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Build", nil), [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleVersion"]]]];
    [[self tableValues] addObject:[CFLAppConfigManageTableValue valueForInfo:[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"iOS version", nil), [[UIDevice currentDevice] systemVersion]]]];
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
    CFLAppConfigManageTableValue *tableValue = (CFLAppConfigManageTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    CFLAppConfigManageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[tableValue cellIdentifier]];
    if (!cell)
    {
        cell = [CFLAppConfigManageTableCell new];
    }
    
    //Set up a loader list cell
    if (tableValue.type == CFLAppConfigManageTableValueTypeLoading)
    {
        //Create view
        CFLAppConfigManageLoadingCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigManageLoadingCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigManageLoadingCell *)cell.cellView;
        }
        
        //Supply data
        cellView.loadingText = tableValue.labelString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }
    
    //Set up a config cell
    if (tableValue.type == CFLAppConfigManageTableValueTypeConfig)
    {
        //Create view
        CFLAppConfigManageItemCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigManageItemCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigManageItemCell *)cell.cellView;
        }
        
        //Supply data
        cell.userInteractionEnabled = [tableValue.config length] > 0;
        cellView.userInteractionEnabled = [tableValue.config length] > 0;
        cellView.configText = tableValue.labelString;
        
        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Set up an info cell
    if (tableValue.type == CFLAppConfigManageTableValueTypeInfo)
    {
        //Create view
        CFLAppConfigManageInfoCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigManageInfoCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigManageInfoCell *)cell.cellView;
        }
        
        //Supply data
        cellView.infoText = tableValue.labelString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //Calculate frame
        CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        bounds.width = MAX(bounds.width, self.frame.size.width);
        cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
    }

    //Set up a section cell
    if (tableValue.type == CFLAppConfigManageTableValueTypeSection)
    {
        //Create view
        CFLAppConfigManageSectionCell *cellView;
        if (!cell.cellView)
        {
            cellView = [CFLAppConfigManageSectionCell new];
            cell.cellView = cellView;
        }
        else
        {
            cellView = (CFLAppConfigManageSectionCell *)cell.cellView;
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
    CFLAppConfigManageTableValue *tableValue = (CFLAppConfigManageTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    return tableValue.type == CFLAppConfigManageTableValueTypeConfig;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:NSLocalizedString(@"Edit", nil) handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        CFLAppConfigManageTableValue *tableValue = (CFLAppConfigManageTableValue *)[self.tableValues objectAtIndex:indexPath.row];
        if (self.delegate)
        {
            if (tableValue.config)
            {
                [self.delegate editConfig:tableValue.config];
            }
        }
        [tableView setEditing:NO animated:YES];
    }];
    editAction.backgroundColor = [UIColor blueColor];
    return @[editAction];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigManageTableCell *cell = (CFLAppConfigManageTableCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    if (cell && cell.cellView)
    {
        return [cell.cellView sizeThatFits:self.frame.size].height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigManageTableValue *tableValue = (CFLAppConfigManageTableValue *)[self.tableValues objectAtIndex:indexPath.row];
    if (self.delegate)
    {
        if (tableValue.config)
        {
            [self.delegate selectedConfig:tableValue.config];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
