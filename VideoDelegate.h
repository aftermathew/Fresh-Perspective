//
//  VideoDelegate.h
//  FreshPerspective
//
//  Created by Mathew Chasan on 5/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface VideoDelegate : NSObject {

}
- (void)captureOutput:(QTCaptureOutput *)captureOutput didOutputVideoFrame:(CVImageBufferRef)videoFrame
		withSampleBuffer:(QTSampleBuffer *)sampleBuffer		
	   fromConnection:(QTCaptureConnection *)connection;
											     - (NSString *) NameMe;
@end
