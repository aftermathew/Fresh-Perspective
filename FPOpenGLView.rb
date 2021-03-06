#
#  fpOpenGLView.rb
#  FreshPerspective
#
#  Created by Mathew Chasan on 5/17/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

framework 'OpenGL'
framework 'Cocoa'
framework 'QuickTime'
framework 'QTKit'
framework 'glut'
framework 'QuickTime'

class FPOpenGLView < NSOpenGLView
  attr_accessor :rotX

  def init
    super

    @rotX = 0.0
    @color = 0.0
    timer = NSTimer.timerWithTimeInterval(1.0/60.0,
                                          target:self,
                                          selector:'drawRect:',
                                          userInfo:nil,
                                          repeats:true)

    NSRunLoop.currentRunLoop.addTimer timer, forMode:NSDefaultRunLoopMode
    NSRunLoop.currentRunLoop.addTimer timer, forMode:NSEventTrackingRunLoopMode

    CGDirectDisplayID   displayID = CGMainDisplayID()
    error = CVDisplayLinkCreateWithCGDisplay(displayID, @displayLink);
    if(error)
      NSLog("DisplayLink created with error:%d", error)
      @displayLink = NULL
      return
    end
    error = CVDisplayLinkSetOutputCallback(@displayLink, MyDisplayLinkCallback, self);
    if(error)
      NSLog("DisplayLink callback error:%d",error)
      @displayLink = NULL
      return
    end
    self
  end


  def MyDisplayLinkCallback (displayLink,inNow, inOutputTime, flagsIn, flagsOut, displayLinkContext)
    NSLog "callback is called"
  end

  def initialize
    #why does initialize not get called?
    warn "in initialize of FPOpenGLView"
    super
  end

  def drawObject
#    NSLog "In draw object #{@color}"
    glColor3d(1.0, @color, 0.35)

    glBegin GL_TRIANGLES
    glVertex3f 0.0, 0.6, 0.0
    glVertex3f -0.2, -0.3, 0.0
    glVertex3f 0.2, -0.3 ,0.0
    glEnd
  end


  def drawRect bounds
#    warn "drawRect was called"
    init unless @rotX
    @rotX += 1
    @color += 0.0002
    glClearColor(0, 0, 0, 0)
    glClear(GL_COLOR_BUFFER_BIT)
    glLoadIdentity
    glRotatef(@rotX,1,1,1)
    drawObject
    glFlush

  end

  def rotate
    @rotX += 1
    drawRect bounds
  end

  def resetGLView
    @rotX = 0
    drawRect bounds
  end

end
