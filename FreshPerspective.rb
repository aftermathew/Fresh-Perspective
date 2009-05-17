#
#  FreshPerspective.rb
#  FreshPerspective
#
#  Created by Mathew Chasan on 5/17/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#


# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'
framework 'ScreenSaver'
framework 'Foundation'
framework 'AppKit'

# Loading all the Ruby project files.
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.entries(dir_path).each do |path|
  if path != File.basename(__FILE__) and path[-3..-1] == '.rb'
    require(path)
  end
end

class FreshPerspectiveView < ScreenSaverView

def initWithFrame(frame, isPreview:isPreview)
	self = super frame, isPreview
	if(self)
		setAnimationTimeInterva(1.0 / 30.0)
	end
	self
end

def startAnimation
	super
end


def stopAnimation
	super
end	

def drawRect(rect)
	super rect
end

def animateOneFrame
	
end

def hasConfigureSheet
	false
end

def configureSheet
	nil
end


end
