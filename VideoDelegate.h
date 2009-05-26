//
//  QTVideoControl.h
//  MyScreenSaver
//
//  Created by Mathew Chasan on 5/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface MyQTVideoControl : NSObject {
    QTCaptureDevice *device;
    QTCaptureSession *captureSession;
    QTCaptureVideoPreviewOutput *captureOutput;
    QTCaptureDeviceInput *deviceInput;
}

- (void) startCapture;
- (void) stopCapture;
- (void) prepareDevice:(QTCaptureDevice *) device_;
- (void) setCaptureDelegate:(id)delegate;
- (void)captureOutput:(QTCaptureOutput *)captureOutput
  didOutputVideoFrame:(CVImageBufferRef)videoFrame
     withSampleBuffer:(QTSampleBuffer *)sampleBuffer
       fromConnection:(QTCaptureConnection *)connection;

@end
