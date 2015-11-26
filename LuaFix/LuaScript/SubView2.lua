waxClass{"SubView2", UIView}

function initWithFrame(self,frame)
    self.super:initWithFrame(frame)
    self:setBackgroundColor(UIColor:redColor())
    print("SubView2 init")
    return self
end
