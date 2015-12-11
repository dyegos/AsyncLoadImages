//
//  ViewController.swift
//  asyncImageLoading
//
//  Created by Dyego Silva on 11/12/15.
//  Copyright (c) 2015 curso. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var destination = segue.destinationViewController as UIViewController
        if let navCon = destination as? UINavigationController
        {
            destination = navCon.visibleViewController!
        }
        
        if let dvc = destination as? PresentImageViewController
        {
            if let identifier = segue.identifier
            {
                dvc.title = identifier
                
                switch identifier
                {
                case "ShowOcean":
                    dvc.imageURL = NASASpaceImageHD.Ocean
                case "ShowNebula":
                    dvc.imageURL = NASASpaceImageHD.Nebula
                case "ShowSaturn":
                    dvc.imageURL = NASASpaceImageHD.Saturn
                case "ShowEarthNight":
                    dvc.imageURL = NASASpaceImageHD.EarthAtNight
                case "ShowDarkHole":
                    dvc.imageURL = NASASpaceImageHD.DarkHole
                default: break
                }
            }
        }
    }
}

