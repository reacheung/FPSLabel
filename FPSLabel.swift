//
//  FPSLabel.swift
//  LiaoLiao
//
//  Created by reacheung on 2019/3/25.
//  Copyright © 2019 链行天下. All rights reserved.
//  帧率监控 1秒60HZ最优


import UIKit

class FPSLabel: UILabel {
    
    private var _link :CADisplayLink?
    private var _count:Int = 0
    private var _lastTime:TimeInterval = 0
    private let _defaultSize = CGSize(width: 50.autoValue, height: 22.autoValue)
    
    override init(frame: CGRect) {
        
        var targetFrame = frame
        
        if frame.size.width == 0 && frame.size.height == 0 {
            targetFrame.size = _defaultSize
        }
        
        super.init(frame: targetFrame)
        self.layer.cornerRadius = 5.autoValue
        self.clipsToBounds = true
        self.textAlignment = .center
        self.isUserInteractionEnabled = false
        self.textColor = UIColor.white
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.font = CustomFont.mediumFontWithSize(14.autoValue)
        weak var weakSelf = self
        _link = CADisplayLink(target: weakSelf!, selector:#selector(FPSLabel.tick(_ :)) );
        _link?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tick(_ link:CADisplayLink) {
        if _lastTime == 0 {
            _lastTime = link.timestamp
            return
        }
        _count += 1
        let delta = link.timestamp - _lastTime
        if delta < 1 {
            return
        }
        _lastTime = link.timestamp
        let fps = Double(_count) / delta
        _count = 0
        let progress = fps / 60.0;
        self.textColor = UIColor(hue: CGFloat(0.27 * ( progress - 0.2 )) , saturation: 1, brightness: 0.9, alpha: 1)
        self.text = "\(Int(fps+0.5))FPS"
    }
}

