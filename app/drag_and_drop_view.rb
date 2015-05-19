class DragAndDropView < NSImageView
  def draggingEntered(info)
    self.highlight!
    NSDragOperationCopy
  end

  def draggingExited(info)
    self.unhighlight!
  end

  def prepareForDragOperation(info)
    self.unhighlight!
  end

  def performDragOperation(info)
    if info.draggingSource != self
      if NSImage.canInitWithPasteboard(info.draggingPasteboard)
        image = NSImage.alloc.initWithPasteboard(info.draggingPasteboard)
      else
        image = NSImage.imageNamed("file_icon")
      end
      self.setImage(image)
    end
  end

  def highlight!
    @highlight = true
    self.needsDisplay = true
  end

  def unhighlight!
    @highlight = false
    self.needsDisplay = true
  end

  def drawRect(frame)
    super(frame)

    if @highlight
      NSColor.grayColor.set
      NSBezierPath.setDefaultLineWidth(5)
      NSBezierPath.strokeRect(frame)
    end
  end
end