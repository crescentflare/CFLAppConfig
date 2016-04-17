//
//  CFLAppConfigManageInfoCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageInfoCell.h"

//Definition
static CGFloat kEdgePadding = 8;

//Internal interface definition
@interface CFLAppConfigManageInfoCell ()

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigManageInfoCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Add info text
        self.backgroundColor = [UIColor whiteColor];
        self.infoLabel = [UILabel new];
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.numberOfLines = 0;
        [self addSubview:self.infoLabel];
        
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
    CGSize labelSize = [self.infoLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    return CGSizeMake(size.width, kEdgePadding + labelSize.height + kEdgePadding + [self dividerHeight]);
}

- (void)layoutSubviews
{
    self.infoLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight]);
    self.divider.frame = CGRectMake(0, self.frame.size.height - [self dividerHeight], self.frame.size.width, [self dividerHeight]);
}

- (CGFloat)dividerHeight
{
    return 1.0f / [[UIScreen mainScreen] scale];
}


#pragma mark Property accessors

- (void)setInfoText:(NSString *)infoText
{
    self.infoLabel.text = infoText;
}

- (NSString *)infoText
{
    return self.infoLabel.text;
}

@end
