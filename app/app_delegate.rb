class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow

    @drag_and_drop = DragAndDropView.alloc.initWithFrame(CGRectZero)
    @drag_and_drop.delegate = self
    self.set_drag_and_drop_frame
    @mainWindow.contentView.addSubview(@drag_and_drop)

    @label = NSTextField.alloc.initWithFrame(CGRectZero)
    @label.bezeled = false
    @label.drawsBackground = false
    @label.editable = false
    @label.selectable = false
    @label.alignment = NSCenterTextAlignment
    @label.stringValue = "Drag a file above"
    self.set_label_frame
    @mainWindow.contentView.addSubview @label
  end

  def set_drag_and_drop_frame
    window_size = @mainWindow.frame.size
    drag_and_drop_size = [200, 200]
    @drag_and_drop.frame = [
      [(window_size.width / 2.0) - (drag_and_drop_size[0] / 2.0), (window_size.height / 2.0) - (drag_and_drop_size[1] / 2.0)],
      drag_and_drop_size
    ]
  end

  def set_label_frame
    window_size = @mainWindow.frame.size
    label_size = [200, 50]
    @label.frame = [
      [(window_size.width / 2.0) - (label_size[0] / 2.0), @drag_and_drop.frame.origin.y - label_size[1]],
      label_size
    ]
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
    @mainWindow.delegate = self
  end

  def windowDidResize(sender)
    self.set_drag_and_drop_frame
    self.set_label_frame
  end

  def drag_received_for_file_paths(paths)
    @label.stringValue = "Received: #{paths.join(',')}"
  end

  def drag_received_for_text(text)
    @label.stringValue = "Received: #{text}"
  end
end