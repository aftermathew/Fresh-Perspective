//
//  FreshPerspectiveView.m
//  FreshPerspective
//
//  Created by Mathew Chasan on 5/17/09.
//  Copyright (c) 2009, __MyCompanyName__. All rights reserved.
//

#import "FreshPerspectiveView.h"


@implementation FreshPerspectiveView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
