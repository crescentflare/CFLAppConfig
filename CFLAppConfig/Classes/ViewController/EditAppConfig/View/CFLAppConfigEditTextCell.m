//
//  CFLAppConfigEditTextCell.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigEditTextCell.h"

//Definition
static CGFloat kEdgePadding = 8;
static CGFloat kBetweenSpacing = 4;

//Internal interface definition
@interface CFLAppConfigEditTextCell ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UITextField *textEntry;
@property (nonatomic, strong) UIView *divider;

@end

//Interface implementation
@implementation CFLAppConfigEditTextCell

#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        //Add label
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel = [UILabel new];
        self.textLabel.font = [UIFont systemFontOfSize:10];
        self.textLabel.textColor = self.tintColor;
        self.textLabel.numberOfLines = 0;
        [self addSubview:self.textLabel];
        
        //Add editable field
        self.textEntry = [UITextField new];
        [self addSubview:self.textEntry];

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
    CGSize labelSize = [self.textLabel sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    CGSize entrySize = [self.textEntry sizeThatFits:CGSizeMake(size.width - kEdgePadding * 2, 0)];
    return CGSizeMake(size.width, kEdgePadding + labelSize.height + kBetweenSpacing + entrySize.height + kEdgePadding + [self dividerHeight]);
}

- (void)layoutSubviews
{
    CGSize labelSize = [self.textLabel sizeThatFits:CGSizeMake(self.frame.size.width - kEdgePadding * 2, 0)];
    self.textLabel.frame = CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2, labelSize.height);
    self.textEntry.frame = CGRectMake(kEdgePadding, kEdgePadding + labelSize.height + kBetweenSpacing, self.frame.size.width - kEdgePadding * 2, self.frame.size.height - kEdgePadding * 2 - [self dividerHeight] - kBetweenSpacing - labelSize.height);
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

- (void)setEditedText:(NSString *)editedText
{
    self.textEntry.text = editedText;
}

- (NSString *)editedText
{
    return self.textEntry.text;
}

@end
