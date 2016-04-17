//
//  CFLAppConfigManageSectionCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageSectionCell.h"

//Definition
static CGFloat kEdgePadding = 8;

//Internal interface definition
@interface CFLAppConfigManageSectionCell ()

@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigManageSectionCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Add label for section
        self.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];
        self.sectionLabel = [UILabel new];
        self.sectionLabel.font = [UIFont systemFontOfSize:14];
        self.sectionLabel.textColor = [UIColor darkGrayColor];
        self.sectionLabel.numberOfLines = 0;
        [self addSubview:self.sectionLabel];
        
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
    CGSize labelSize = [self.sectionLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    return CGSizeMake(size.width, kEdgePadding + labelSize.height + kEdgePadding + [self dividerHeight]);
}

- (void)layoutSubviews
{
    self.sectionLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.divider.frame = CGRectMake(0, self.frame.size.height - [self dividerHeight], self.frame.size.width, [self dividerHeight]);
}

- (CGFloat)dividerHeight
{
    return 1.0f / [[UIScreen mainScreen] scale];
}


#pragma mark Property accessors

- (void)setSectionText:(NSString *)sectionText
{
    self.sectionLabel.text = sectionText;
}

- (NSString *)sectionText
{
    return self.sectionLabel.text;
}

@end
