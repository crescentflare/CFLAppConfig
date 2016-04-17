//
//  CFLAppConfigManageLoadingCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageLoadingCell.h"

//Definitions
static CGFloat kEdgePadding = 8;
static CGFloat kSpinnerOffset = 4;
static CGFloat kLabelOffset = 8;

//Internal interface definition
@interface CFLAppConfigManageLoadingCell ()

@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UILabel *loadingLabel;

@end

//Interface implementation
@implementation CFLAppConfigManageLoadingCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Add loading spinner
        self.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];
        self.spinner = [UIActivityIndicatorView new];
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.spinner startAnimating];
        [self addSubview:self.spinner];
        
        //Add loading text
        self.loadingLabel = [UILabel new];
        self.loadingLabel.textAlignment = NSTextAlignmentCenter;
        self.loadingLabel.textColor = [UIColor darkGrayColor];
        self.loadingLabel.numberOfLines = 0;
        [self addSubview:self.loadingLabel];
    }
    return self;
}


#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize spinnerSize = [self.spinner sizeThatFits:CGSizeZero];
    CGSize labelSize = [self.loadingLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    return CGSizeMake(size.width, kEdgePadding + kSpinnerOffset + spinnerSize.height + kLabelOffset + labelSize.height + kEdgePadding);
}

- (void)layoutSubviews
{
    //Layout spinner
    CGSize spinnerSize = [self.spinner sizeThatFits:CGSizeZero];
    self.spinner.frame = CGRectMake(self.frame.size.width / 2 - spinnerSize.width / 2, kEdgePadding + kSpinnerOffset, spinnerSize.width, spinnerSize.height);
    
    //Layout label
    CGFloat labelOffset = kEdgePadding + kSpinnerOffset + spinnerSize.height + kLabelOffset;
    self.loadingLabel.frame = CGRectMake(kEdgePadding, labelOffset, self.frame.size.width - kEdgePadding * 2, self.frame.size.height - labelOffset - kEdgePadding);
}


#pragma mark Property accessors

- (void)setLoadingText:(NSString *)loadingText
{
    self.loadingLabel.text = loadingText;
}

- (NSString *)loadingText
{
    return self.loadingLabel.text;
}

@end
