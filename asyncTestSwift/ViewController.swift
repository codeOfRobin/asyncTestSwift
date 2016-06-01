//
//  ViewController.swift
//  asyncTestSwift
//
//  Created by Robin Malhotra on 01/06/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let smallData = (0..<100).map{_ in return ["x":Float.random(-1, upper: 1)]}
        let mediumData = (0..<10000).map{_ in return ["x":Float.random(-1, upper: 1)]}
        let largeData = (0..<1000000).map{_ in return ["x":Float.random(-1, upper: 1)]}
        
        
        deleteAndCreateAt("\(NSBundle.mainBundle().bundlePath)/large.json", withData: largeData.description.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        deleteAndCreateAt("\(NSBundle.mainBundle().bundlePath)/medium.json", withData: mediumData.description.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        deleteAndCreateAt("\(NSBundle.mainBundle().bundlePath)/small.json", withData: smallData.description.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func deleteAndCreateAt(path:String,withData:NSData)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
        {
            if NSFileManager.defaultManager().fileExistsAtPath(path)
            {
                do
                {
                    try NSFileManager.defaultManager().removeItemAtPath(path)
                }
                catch
                {
                    print("bahut bura hua")
                }
            }
            NSFileManager.defaultManager().createFileAtPath(path, contents: withData, attributes: nil)
            dispatch_async(dispatch_get_main_queue(),
                {
                    print("ho gaya" + path)
            })
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

public extension Float
{
    public static func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
    
}

