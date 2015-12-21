//
//  PresentImageViewController.swift
//  asyncImageLoading
//
//  Created by Dyego Silva on 11/12/15.
//  Copyright (c) 2015 curso. All rights reserved.
//

import UIKit

class PresentImageViewController: UIViewController, UIScrollViewDelegate
{
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    {
        didSet
        {
            myScrollView.contentSize = imageView.frame.size
            myScrollView.delegate = self
            myScrollView.minimumZoomScale = 0.03
            myScrollView.maximumZoomScale = 1.0
        }
    }
    lazy private var imageView: UIImageView = UIImageView()
    
    private var displayImage: UIImage?
    {
        get { return imageView.image }
        set
        {
            imageView.image = newValue
            imageView.sizeToFit()
            imageView.alpha = 0.0
            UIView.animateWithDuration(1)
            { //[unowned self] in
                self.imageView.alpha = 1.0
            }
            myScrollView?.zoomToRect(imageView.bounds, animated: true)
            myScrollView?.contentSize = imageView.frame.size
        }
    }
    
    var imageURL: NSURL?
    {
        didSet
        {
            displayImage = nil
            if view.window != nil { fetchImage() }
        }
    }
    
    //MARK: - UIView Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myScrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if displayImage == nil { fetchImage() }
    }
    
    //MARK: - Fetch
    
    private func fetchImage()
    {
        if let url = imageURL
        {
            dispatch_async(getQOSUserInitiated())
            {
                let imageData = NSData(contentsOfURL: url)
                
                dispatch_async(dispatch_get_main_queue())
                {
                    if imageData != nil
                    {
                        self.displayImage = UIImage(data: imageData!)
                    }
                    else { self.displayImage = nil }
                }
            }
        }
    }
    
    //MARK: - Scrollview Delegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return imageView
    }
    
    //MARK: - QOS functions
    
    private func getQOSUserInitiated() -> dispatch_queue_t
    {
        let qos = Int(QOS_CLASS_USER_INITIATED.value)
        return dispatch_get_global_queue(qos, 0)
    }
}
