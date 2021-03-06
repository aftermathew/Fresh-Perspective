#
#  video.rb
#  FreshPerspective
#
#  Created by Mathew Chasan on 5/16/09.
#  Copyright (c) 2009 Mathew Chasan. All rights reserved.
#

framework 'QTKit'
require 'singleton'
require 'pp'
#import 'VideoDelegate.h'

class VideoController < QTCaptureVideoPreviewOutput
  include Singleton

  attr_accessor :device, :buffer

  def initialize
    p "Initializing video controller"
    @device = nil
    @captureSession = QTCaptureSession.new
    @deviceInput = nil
    @delegate = VideoDelegate.new
    @captureOutput = QTCaptureVideoPreviewOutput.new
	@captureOutput.setDelegate self
    @buffer = []
  end

  def captureOutput(output,
                    didOutputVideoFrame:outputFrame,
                    withSampleBuffer:sampleBuffer,
                    fromConnection:connection)
	begin 
		p "hi"
	rescue
	end
  end


  def errorOccured errorString
      warn errorString
      @device.close
FP      @deviceInput = nil
  end

  def openDevice
    return unless @device

    error = nil
    unless(@device.open(error))
      errorOccured "Error opening device"
      return
    end

    @deviceInput = QTCaptureDeviceInput.deviceInputWithDevice @device
    unless (@deviceInput)
      errorOccured "error when creating video device input"
      return
    end

    # Add video device input to capture session.
    unless(@captureSession.addInput(@deviceInput, error:error))
      errorOccured "Error adding input to session"
      return;
    end

    unless(@captureSession.addOutput(@captureOutput, error:error))
      errorOccured "Error adding output to session"
      return;
    end

	p "starting"
  end
  
  def startRunning
	@captureSession.startRunning
  end


  def closeDevice
    @captureSession.stopRunning
  end
end
