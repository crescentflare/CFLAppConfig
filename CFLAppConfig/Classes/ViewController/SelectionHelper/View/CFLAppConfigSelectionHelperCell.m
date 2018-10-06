//
//  CFLAppConfigSelectionHelperCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigSelectionHelperCell.h"
#import "CFLAppConfigBundle.h"

//Definition
static CGFloat kEdgePadding = 8;
static CGFloat kDisclosureWidth = 11;
static CGFloat kDisclosureSpacing = 8;
static CGFloat kMinHeight = 48;

//Internal interface definition
@interface CFLAppConfigSelectionHelperCell ()

@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UIImageView *disclosureImage;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigSelectionHelperCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Initial loading
        UIImage *chevronImage = [CFLAppConfigBundle imageNamed:@"chevron"];
        self.backgroundColor = [UIColor whiteColor];
        
        //Add label for action
        self.actionLabel = [UILabel new];
        self.actionLabel.numberOfLines = 0;
        [self addSubview:self.actionLabel];
        
        //Add accessory image
        self.disclosureImage = [UIImageView new];
        self.disclosureImage.contentMode = UIViewContentModeScaleAspectFit;
        self.disclosureImage.image = chevronImage;
        [self addSubview:self.disclosureImage];
        
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
    CGSize labelSize = [self.actionLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2 - kDisclosureWidth - kDisclosureSpacing, 0)];
    return CGSizeMake(size.width, MAX(kMinHeight, kEdgePadding + labelSize.height + kEdgePadding + [self dividerHeight]));
}

- (void)layoutSubviews
{
    self.actionLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2 - kDisclosureWidth - kDisclosureSpacing, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.disclosureImage.frame = CGRectMake(kEdgePadding + self.actionLabel.frame.size.width + kDisclosureSpacing, kEdgePadding, kDisclosureWidth, self.frame.size.height - kEdgePadding * 2);
    self.divider.frame = CGRectMake(0, self.frame.size.height - [self dividerHeight], self.frame.size.width, [self dividerHeight]);
}

- (CGFloat)dividerHeight
{
    return 1.0f / [[UIScreen mainScreen] scale];
}


#pragma mark Property accessors

- (void)setLabelText:(NSString *)labelText
{
    self.actionLabel.text = labelText;
}

- (NSString *)labelText
{
    return self.actionLabel.text;
}

@end
