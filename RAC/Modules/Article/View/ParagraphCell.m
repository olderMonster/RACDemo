//
//  ParagraphCell.m
//  RAC
//
//  Created by 印聪 on 2018/9/13.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "ParagraphCell.h"

CGFloat const kParagraphCellLabelFontSize = 14;

@interface ParagraphCell()

@property (nonatomic , strong)UILabel *paragraphLabel;

@end

@implementation ParagraphCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.paragraphLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.paragraphLabel.frame = CGRectMake(10, 5, self.contentView.bounds.size.width - 20, self.contentView.bounds.size.height - 5);
}


#pragma mark -- getters and setters
- (UILabel *)paragraphLabel{
    if (_paragraphLabel == nil) {
        _paragraphLabel = [[UILabel alloc] init];
        _paragraphLabel.font = [UIFont systemFontOfSize:kParagraphCellLabelFontSize];
        _paragraphLabel.numberOfLines = 0;
        [_paragraphLabel sizeToFit];
    }
    return _paragraphLabel;
}

- (void)setParagraph:(NSString *)paragraph{
    _paragraph = paragraph;
    self.paragraphLabel.text = _paragraph;
}

@end
