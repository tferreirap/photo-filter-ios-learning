//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    var unfilteredImage: UIImage?
    var showingFilteredImage = false
    var blueFilterSelected = false
    var greyFilterSelected = false
    var contrastFilterSelected = false
    
    @IBOutlet var duplicatedOriginalImage: UIImageView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var filterMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var originalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        filterMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        filterMenu.translatesAutoresizingMaskIntoConstraints = false
        
        unfilteredImage = imageView.image
        duplicatedOriginalImage.image = imageView.image
        compareButton.enabled = false
        editButton.enabled = false
        originalLabel.hidden = true
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        hideFilterMenu()
        editButton.selected = false
        
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }

    @IBAction func onEditFilter(sender: UIButton) {
        hideSecondaryMenu()
        filterButton.selected = false
        
        if (sender.selected) {
            hideFilterMenu()
            sender.selected = false
        } else {
            showFilterMenu()
            sender.selected = true
        }

    }
    
    @IBAction func applyGreyButton(sender: UIButton) {
        let greyFilter = GreyFilter(image: imageView.image!, modifier: 1)
        filteredImage = greyFilter.applyFilter()
        imageView.image = filteredImage
        showingFilteredImage = true
        compareButton.enabled = true
        editButton.enabled = true
        
        greyFilterSelected = true
        contrastFilterSelected = false
        blueFilterSelected = false
        
        self.duplicatedOriginalImage.alpha = 1.0
        UIView.animateWithDuration(0.4) {
            self.duplicatedOriginalImage.alpha = 0.0
        }
    }
    
    @IBAction func applyBlueButton(sender: UIButton) {
        let blueFilter = BlueFilter(image: imageView.image!, modifier: 20)
        filteredImage = blueFilter.applyFilter()
        imageView.image = filteredImage
        showingFilteredImage = true
        compareButton.enabled = true
        editButton.enabled = true

        greyFilterSelected = false
        contrastFilterSelected = false
        blueFilterSelected = true
        
        self.duplicatedOriginalImage.alpha = 1.0
        UIView.animateWithDuration(0.4) {
            self.duplicatedOriginalImage.alpha = 0.0
        }
    }
    
    @IBAction func applyContrastButton(sender: UIButton) {
        let contrastFilter = ContrastFilter(image: imageView.image!, modifier: 2)
        filteredImage = contrastFilter.applyFilter()
        imageView.image = filteredImage
        showingFilteredImage = true
        compareButton.enabled = true
        editButton.enabled = true

        greyFilterSelected = false
        contrastFilterSelected = true
        blueFilterSelected = false
        
        self.duplicatedOriginalImage.alpha = 1.0
        UIView.animateWithDuration(0.4) {
            self.duplicatedOriginalImage.alpha = 0.0
        }
    }
    
    @IBAction func compare(sender: UIButton) {
        if (showingFilteredImage) {
            if (filteredImage != nil) {
                //imageView.image = unfilteredImage
                showingFilteredImage = false
                originalLabel.hidden = false
                self.duplicatedOriginalImage.alpha = 0.0
                UIView.animateWithDuration(0.4) {
                    self.duplicatedOriginalImage.alpha = 1.0
                }
            }
        } else {
            if (filteredImage != nil) {
                //imageView.image = filteredImage
                showingFilteredImage = true
                originalLabel.hidden = true
                self.duplicatedOriginalImage.alpha = 1.0
                UIView.animateWithDuration(0.4) {
                    self.duplicatedOriginalImage.alpha = 0.0
                }
            }
        }
    }
    
    @IBAction func showOriginalImage(sender: UIButton) {
        if (filteredImage != nil) {
            showingFilteredImage = true
            originalLabel.hidden = true
            self.duplicatedOriginalImage.alpha = 1.0
            UIView.animateWithDuration(0.4) {
                self.duplicatedOriginalImage.alpha = 0.0
            }
        }
        
    }
    
    @IBAction func showFilteredImage(sender: UIButton) {
        if (filteredImage != nil) {
            showingFilteredImage = false
            originalLabel.hidden = false
            self.duplicatedOriginalImage.alpha = 0.0
            UIView.animateWithDuration(0.4) {
                self.duplicatedOriginalImage.alpha = 1.0
            }
        }
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        if (blueFilterSelected) {
            let blueFilter = BlueFilter(image: unfilteredImage!, modifier: currentValue)
            filteredImage = blueFilter.applyFilter()
            imageView.image = filteredImage
            
        } else if (greyFilterSelected) {
            let greyFilter = GreyFilter(image: unfilteredImage!, modifier: currentValue)
            filteredImage = greyFilter.applyFilter()
            imageView.image = filteredImage
            
        } else if (contrastFilterSelected) {
            let contrastFilter = ContrastFilter(image: unfilteredImage!, modifier: currentValue)
            filteredImage = contrastFilter.applyFilter()
            imageView.image = filteredImage
        }
        
    }
    
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func showFilterMenu() {
        view.addSubview(filterMenu)
        
        let bottomConstraint = filterMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = filterMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = filterMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = filterMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.filterMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.filterMenu.alpha = 1.0
        }
    }
    
    
    func hideFilterMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.filterMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.filterMenu.removeFromSuperview()
                }
        }
    }


}

