//
//  CFLAppConfigManageItemCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageItemCell.h"

//Definitions
static CGFloat kEdgePadding = 8;
static CGFloat kDisclosureWidth = 11;
static CGFloat kDisclosureSpacing = 8;
static CGFloat kMinHeight = 48;

//Internal interface definition
@interface CFLAppConfigManageItemCell ()

@property (nonatomic, strong) UILabel *configLabel;
@property (nonatomic, strong) UIImageView *disclosureImage;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigManageItemCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Initial loading
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"CFLAppConfig" withExtension:@"bundle"]];
        UIImage *chevronImage = [UIImage imageNamed:@"chevron" inBundle:bundle compatibleWithTraitCollection:nil];
        self.backgroundColor = [UIColor whiteColor];
        
        //Add label for config
        self.configLabel = [UILabel new];
        self.configLabel.numberOfLines = 0;
        [self addSubview:self.configLabel];
        
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
    CGSize labelSize = [self.configLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2 - kDisclosureWidth - kDisclosureSpacing, 0)];
    return CGSizeMake(size.width, MAX(kMinHeight, kEdgePadding + labelSize.height + kEdgePadding + [self dividerHeight]));
}

- (void)layoutSubviews
{
    self.configLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2 - kDisclosureWidth - kDisclosureSpacing, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.disclosureImage.frame = CGRectMake(kEdgePadding + self.configLabel.frame.size.width + kDisclosureSpacing, kEdgePadding, kDisclosureWidth, self.frame.size.height - kEdgePadding * 2);
    self.divider.frame = CGRectMake(0, self.frame.size.height - [self dividerHeight], self.frame.size.width, [self dividerHeight]);
}

- (CGFloat)dividerHeight
{
    return 1.0f / [[UIScreen mainScreen] scale];
}


#pragma mark Property accessors

- (void)setConfigText:(NSString *)configText
{
    self.configLabel.text = configText;
}

- (NSString *)configText
{
    return self.configLabel.text;
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    self.disclosureImage.hidden = !userInteractionEnabled;
}

@end
