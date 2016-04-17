//
//  CFLAppConfigManageTableCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageTableCell.h"

//Internal interface definition
@interface CFLAppConfigManageTableCell ()

@property (nonatomic, strong) UIView *customCellView;

@end

//Interface implementation
@implementation CFLAppConfigManageTableCell

#pragma mark Property Accessors

- (void)setCellView:(UIView *)cellView
{
    if (self.customCellView)
    {
        [self.customCellView removeFromSuperview];
    }
    self.customCellView = cellView;
    if (cellView)
    {
        [self.contentView addSubview:cellView];
    }
}

- (UIView *)cellView
{
    return self.customCellView;
}


#pragma mark Overrides

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.shouldHideDivider)
    {
        self.separatorInset = UIEdgeInsetsMake(0, self.frame.size.width * 2, 0, 0);
    }
    if (self.customCellView)
    {
        self.customCellView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.customCellView)
    {
        return [self.customCellView sizeThatFits:size];
    }
    return CGSizeZero;
}

@end
