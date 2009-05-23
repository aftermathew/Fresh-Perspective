//
//  VideoDelegate.m
//  FreshPerspective
//
//  Created by Mathew Chasan on 5/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "VideoDelegate.h"


@implementation VideoDelegate
- (void)captureOutput:(QTCaptureOutput *)captureOutput
  didOutputVideoFrame:(CVImageBufferRef)videoFrame
     withSampleBuffer:(QTSampleBuffer *)sampleBuffer
       fromConnection:(QTCaptureConnection *)connection
{
    NSLog("mother are you with me?");
    //    NSLog("Buffer attributes %@", [[sampleBuffer sampleBufferAttributes] description]);
}

- (NSString *) NameMe{
    return @"My name is mathew";
}
@end
