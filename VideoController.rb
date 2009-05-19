#
#  video.rb
#  FreshPerspective
#
#  Created by Mathew Chasan on 5/16/09.
#  Copyright (c) 2009 Mathew Chasan. All rights reserved.
#

framework 'QTKit'
require 'singleton'

class VideoController
  include Singleton

  attr_accessor :device

  def initialize
    p "Initializing video controller"
    @device = nil
    @captureSession = QTCaptureSession.new
    @deviceInput = nil
    @captureOutput = QTCaptureVideoPreviewOutput.new
    @captureOutput.setDelegate self
  end

  def captureOutput(output,
                    didOutputVideoFrame:ouputFrame,
                    withSampleBuffer:sampleBuffer,
                    fromConnection:connection)

    STDOUT.p "hellO"
#    pp sampleBuffer.sampleBufferAttributes
#    warn "hello"
  end


  def errorOccured errorString
      warn errorString
      @device.close
      @deviceInput = nil
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

    @captureSession.startRunning
  end

end
