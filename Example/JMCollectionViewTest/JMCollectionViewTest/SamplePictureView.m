//
//  SamplePictureView.m
//  JMCollectionViewTest
//
//  Created by John Matze on 2/6/17.
//  Copyright © 2017 Seaboden. All rights reserved.
//

#import "SamplePictureView.h"

@implementation SamplePictureView

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat padding = 6;
    CGFloat imageViewPadding = 4;

    [self.content setFrame:CGRectMake(padding, padding, frame.size.width-padding*2, frame.size.height-padding*2)];
    [self.imageView setFrame:CGRectMake(imageViewPadding, imageViewPadding, self.content.frame.size.width-imageViewPadding*2, self.content.frame.size.width-imageViewPadding*2)];
}

- (UIView *)content
{
    if (_content)
        return _content;
    _content = [[UIView alloc] init];
    _content.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _content.layer.borderWidth = 1.0;
    [_content setBackgroundColor:[UIColor whiteColor]];

    _content.layer.cornerRadius = 1.0f;
    _content.layer.shadowOffset = CGSizeMake(0, 3);
    _content.layer.shadowColor = [[UIColor blackColor] CGColor];
    _content.layer.shadowRadius = 3.0;
    _content.layer.shadowOpacity = .4;

    [self addSubview:_content];
    return _content;
}

- (UIImageView *)imageView
{
    if (_imageView)
        return _imageView;
    _imageView = [[UIImageView alloc] init];
    [_imageView setImage:[UIImage imageNamed:@"vector_cat"]];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _imageView.layer.borderWidth = 1.0;
    [self.content addSubview:_imageView];
    return _imageView;
}

@end
