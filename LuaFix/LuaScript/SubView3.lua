waxClass{"SubView3", UIView}

function initWithFrame(self,frame)
    self.super:initWithFrame(frame)
    self:setBackgroundColor(UIColor:greenColor())
    print("SubView3 init")
    return self
end
