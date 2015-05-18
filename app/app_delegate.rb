class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow

    @drag_and_drop = DragAndDropView.alloc.initWithFrame(CGRectZero)
    self.set_drag_and_drop_frame
    @mainWindow.contentView.addSubview(@drag_and_drop)
  end

  def set_drag_and_drop_frame
    window_size = @mainWindow.frame.size
    drag_and_drop_size = [200, 200]
    @drag_and_drop.frame = [
      [(window_size.width / 2.0) - (drag_and_drop_size[0] / 2.0), (window_size.height / 2.0) - (drag_and_drop_size[1] / 2.0)],
      drag_and_drop_size
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
  end
end