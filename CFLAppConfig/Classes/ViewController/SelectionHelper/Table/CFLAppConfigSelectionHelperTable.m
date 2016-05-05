//
//  CFLAppConfigSelectionHelperTable.m
//  CFLAppConfig Pod
//

//Imports
#import "CFLAppConfigSelectionHelperTable.h"
#import "CFLAppConfigSelectionHelperTableCell.h"
#import "CFLAppConfigSelectionHelperCell.h"

//Internal interface definition
@interface CFLAppConfigSelectionHelperTable ()

@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) UITableView *tableView;

@end

//Interface implementation
@implementation CFLAppConfigSelectionHelperTable

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
        [self setChoices:@[]];
    }
    return self;
}


#pragma mark Layout

- (void)layoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark Implementation

- (void)setChoices:(NSArray *)choices
{
    _choices = choices;
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create cell (if needed)
    NSString *choice = [self.choices objectAtIndex:indexPath.row];
    CFLAppConfigSelectionHelperTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CFLAppConfigSelectionHelperCell"];
    if (!cell)
    {
        cell = [CFLAppConfigSelectionHelperTableCell new];
    }
    
    //Create cell content
    CFLAppConfigSelectionHelperCell *cellView;
    if (!cell.cellView)
    {
        cellView = [CFLAppConfigSelectionHelperCell new];
        cell.cellView = cellView;
    }
    else
    {
        cellView = (CFLAppConfigSelectionHelperCell *)cell.cellView;
    }
    
    //Supply data
    cellView.labelText = choice;

    //Calculate frame
    CGSize bounds = [cellView sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    bounds.width = MAX(bounds.width, self.frame.size.width);
    cellView.frame = CGRectMake(0, 0, bounds.width, bounds.height);

    //Return result
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLAppConfigSelectionHelperTableCell *cell = (CFLAppConfigSelectionHelperTableCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    if (cell && cell.cellView)
    {
        return [cell.cellView sizeThatFits:self.frame.size].height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *choice = [self.choices objectAtIndex:indexPath.row];
    if (self.delegate)
    {
        [self.delegate chosenItem:choice];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
