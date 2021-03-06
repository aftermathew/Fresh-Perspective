#
#  SettingsController.rb
#  FreshPerspective
#
#  Created by Mathew Chasan on 5/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#


framework 'QTKit'
require 'singleton'


require 'pp'

class SettingsController
  include Singleton

  attr_accessor :audio_combo, :video_combo, :refresh_button
  attr_accessor :glview, :start_button, :print_button, :stop_button


  def initialize
    @audio_devices = []
    @video_devices = []
  end

  def awakeFromNib
    reload_devices
  end

  def reload_devices
    @audio_devices.clear
    @video_devices.clear

    QTCaptureDevice.inputDevices.each do |d|
      if(d.hasMediaType(QTMediaTypeSound))
        @audio_devices << d
      elsif (d.hasMediaType(QTMediaTypeVideo))
        @video_devices << d
        d.formatDescriptions.each{ |desc| pp desc.localizedFormatSummary }
      end
    end

    update_combo @audio_combo, @audio_devices
    update_combo @video_combo, @video_devices
  end

  def update_combo combo, devices
    combo.removeAllItems
    combo.addItemsWithObjectValues devices.map{ |d| d.localizedDisplayName}
    combo.selectItemAtIndex 0
  end

  def refreshClicked(sender)
    reload_devices
  end

  def startClicked(sender)
    device = @video_devices[@video_combo.indexOfSelectedItem]
    #VideoController.instance.openDevice

	@video = FPQTVideoControl.new
	@video.prepareDevice device
	@video.startCapture

  end

  def printClicked(sender)
   # VideoController.instance.startRunning
  end

  def stopClicked(sender)
   # VideoController.instance.closeDevice
   @video.stopCapture
  end
end
