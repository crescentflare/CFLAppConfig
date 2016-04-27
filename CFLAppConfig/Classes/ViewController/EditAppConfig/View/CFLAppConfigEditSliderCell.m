//
//  CFLAppConfigEditSliderCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigEditSliderCell.h"

//Definition
static CGFloat kEdgePadding = 8;
static CGFloat kSwitchSpacing = 6;

//Internal interface definition
@interface CFLAppConfigEditSliderCell ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigEditSliderCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Add label
        self.textLabel = [UILabel new];
        self.textLabel.numberOfLines = 0;
        [self addSubview:self.textLabel];
        
        //Add switch
        self.backgroundColor = [UIColor whiteColor];
        self.switchControl = [UISwitch new];
        self.switchControl.onTintColor = self.tintColor;
        [self addSubview:self.switchControl];
        
        //Add divider line
        self.divider = [UIView new];
        self.divider.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.divider];
    }
    return self;
}


#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize switchSize = [self.switchControl sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    CGSize labelSize = [self.switchControl sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2 - switchSize.width - kSwitchSpacing, 0)];
    return CGSizeMake(size.width, kEdgePadding + MAX(labelSize.height, switchSize.height) + kEdgePadding + [self dividerHeight]);
}

- (void)layoutSubviews
{
    CGSize switchSize = [self.switchControl sizeThatFits:CGSizeMake(self.frame.size.width - kEdgePadding * 2, 0)];
    self.textLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2 - kSwitchSpacing - switchSize.width, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.switchControl.frame = CGRectMake(self.frame.size.width - kEdgePadding - switchSize.width, kEdgePadding, switchSize.width, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.divider.frame = CGRectMake(0, self.frame.size.height - [self dividerHeight], self.frame.size.width, [self dividerHeight]);
}

- (CGFloat)dividerHeight
{
    return 1.0f / [[UIScreen mainScreen] scale];
}


#pragma mark Property accessors

- (void)setLabelText:(NSString *)labelText
{
    self.textLabel.text = labelText;
}

- (NSString *)labelText
{
    return self.textLabel.text;
}

- (void)setOn:(BOOL)on
{
    self.switchControl.on = on;
}

- (BOOL)on
{
    return self.switchControl.on;
}


#pragma mark Implementation

- (void)toggleState
{
    [self.switchControl setOn:!self.switchControl.on animated:YES];
}

@end
