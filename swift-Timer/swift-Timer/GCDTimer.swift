//
//  GCDTimer.swift
//  swift-Timer
//
//  Created by 廖佩志 on 2019/4/2.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
enum GCDTimerState {
    case normal, suspend, running, cancel
}
class GCDTimer: NSObject {

    static var timers = [String: DispatchSourceTimer]() // 定时器
    static var timersState = [String: GCDTimerState]() // 定时器状态
    static let semphore = DispatchSemaphore(value: 1)   // 锁

    /**
     * startTime: 开始时间, 默认立即开始
     * interval: 间隔时间, 默认1s
     * isRepeats: 是否重复执行, 默认true
     * isAsync: 是否异步, 默认false
     * task: 执行任务
     */
    public class func execTask(startTime: TimeInterval = 0, interval: TimeInterval = 1, isRepeats: Bool = true, isAsync: Bool = false, task: @escaping (() -> Void)) -> String? {

        if (interval <= 0 && isRepeats) || startTime < 0 {
            return nil
        }

        let queue = isAsync ? DispatchQueue(label: "GCDTimer") : DispatchQueue.main
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: .now() + startTime, repeating: 1.0, leeway: .milliseconds(0))

        semphore.wait()
        let name = "\(GCDTimer.timers.count)"
        timers[name] = timer
        timersState[name] = GCDTimerState.running
        semphore.signal()

        timer.setEventHandler {
            task()
            if !isRepeats {
                self.cancelTask(task: name)
            }
        }
        timer.resume()
        return name
    }
    // MARK: - 取消
    public class func cancelTask(task: String?) {
        guard let _task = task else {
            return
        }
        semphore.wait()
        if timersState[_task] == .suspend {
            resumeTask(task: _task)
        }
        getTimer(task: _task)?.cancel()

        if let state = timersState.removeValue(forKey: _task) {
            print("The value \(state) was removed.")
        }

        if let timer = timers.removeValue(forKey: _task) {
            print("The value \(timer) was removed.")
        }
        semphore.signal()
    }

    // MARK: - 暂停
    public class func suspendTask(task: String?) {
        guard let _task = task else {
            return
        }

        if timersState.keys.contains(_task) {
            timersState[_task] = .suspend
            getTimer(task: _task)?.suspend()
        }
    }

    public class func resumeTask(task: String?) {
        guard let _task = task else {
            return
        }

        if timersState.keys.contains(_task) && timersState[_task] != .running {
            getTimer(task: task)?.resume()
            timersState[_task] = .running
        }
    }

    fileprivate class func getTimer(task: String?) -> DispatchSourceTimer? {
        guard let taskS = task else {
            return nil
        }
        if taskS.count == 0 {
            return nil
        }
        guard let timer = GCDTimer.timers[taskS] else {
            return nil
        }
        return timer
    }
}
