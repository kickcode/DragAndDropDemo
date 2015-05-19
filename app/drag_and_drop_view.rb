class DragAndDropView < NSImageView
  attr_accessor :delegate

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

      if info.draggingPasteboard.types.include?('NSFilenamesPboardType')
        files = info.draggingPasteboard.propertyListForType('NSFilenamesPboardType')
        self.send_delegate_event(:drag_received_for_file_paths, files)
      end
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

  def send_delegate_event(name, arg)
    return if self.delegate.nil?
    return unless self.delegate.respond_to?(name.to_sym)

    self.delegate.send(name, arg)
  end
end