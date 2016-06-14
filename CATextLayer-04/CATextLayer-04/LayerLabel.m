//
//  LayerLabel.m
//  CATextLayer-04
//
//  Created by long on 6/13/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "LayerLabel.h"

@implementation LayerLabel

+ (Class)layerClass{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{
    // set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    // we should really derive these from the UILabel setting too
    // but that's complicated, so for now we'll just hard-code them
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}


- (void)awakeFromNib{
    [self setup];
}
#pragma mark -------------------
#pragma mark - Setting
- (void)setText:(NSString *)text{
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font{
    super.font = font;
    CFStringRef  fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef  fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}
@end
