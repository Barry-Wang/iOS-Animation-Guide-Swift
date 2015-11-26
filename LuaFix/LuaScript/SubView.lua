waxClass{"SubView", UIView}

function initWithFrame(self,frame)
    self.super:initWithFrame(frame)
    self:setBackgroundColor(UIColor:redColor())
    print("SubView init")
    return self
end
