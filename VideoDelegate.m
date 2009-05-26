//
//  QTVideoControl.m
//  MyScreenSaver
//
//  Created by Mathew Chasan on 5/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "VideoDelegate.h"

@implementation MyQTVideoControl
- (id) init{
    if((self = [super init])){
		device = nil;
		captureOutput = [[[QTCaptureVideoPreviewOutput alloc] init] retain];
		[captureOutput setDelegate:self];
		captureSession = [[[QTCaptureSession alloc] init] retain];
		deviceInput =nil;
    }
	
	return self;
}

- (void)captureOutput:(QTCaptureOutput *)captureOutput
  didOutputVideoFrame:(CVImageBufferRef)videoFrame
     withSampleBuffer:(QTSampleBuffer *)sampleBuffer
       fromConnection:(QTCaptureConnection *)connection
{
    NSLog(@"%@ %@", [[sampleBuffer formatDescription] formatDescriptionAttributes],
			[[sampleBuffer formatDescription] quickTimeSampleDescription]);
    //    NSLog("Buffer attributes %@", [[sampleBuffer sampleBufferAttributes] description]);
}

- (void) dealloc {
    [captureSession release];
    [captureOutput release];
    if(deviceInput){ [deviceInput release]; }
    if(device) { [device release]; }
    [super dealloc];
}

- (void) setCaptureDelegate:(id)delegate{
    [captureOutput setDelegate:delegate];
}

- (void) startCapture
{
    [captureSession startRunning];
}

- (void) stopCapture
{
    [captureSession stopRunning];
}

- (void) errorOccured:(NSString *)error
{
    NSLog(error);
    if(device){
		[device close];
		[device release];
    }
    deviceInput = nil;
}

- (void) prepareDevice:(QTCaptureDevice *) device_
{
    NSError *error = nil;
    device = device_;
	
    if(!device){
		[self errorOccured:@"Error finding default device"];
    }
    [device retain];
	
    if(![device open:&error]){
		[self errorOccured:@"Error opening device"];
    }
	
    deviceInput = [QTCaptureDeviceInput deviceInputWithDevice:device];
    if(!deviceInput){
		[self errorOccured:@"Error creating video device input"];
		return;
    }
    [deviceInput retain];
	
    if(![captureSession addInput:deviceInput error:&error]){
		[self errorOccured:@"Error adding input to capture session"];
		return;
    }
	
    if(![captureSession addOutput:captureOutput error:&error]){
		[self errorOccured:@"Error adding output to capture session"];
		return;
    }
	
    NSLog(@"Completed video preparation");
}

@end

