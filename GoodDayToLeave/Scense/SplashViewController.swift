//
//  SplashViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/12.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageView: UIView!
    
    lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var splashSlide = [SplashSlide]()
    var viewControllers = [UIViewController]()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashSlide = [SplashSlide(image: UIImage(named: "travel")!, title: "travel", splashTitle: ""),
                       SplashSlide(image: UIImage(named: "travel1")!, title: "travel1", splashTitle: ""),
                       SplashSlide(image: UIImage(named: "travel2")!, title: "travel2", splashTitle: "")]
        setupPageViewController()
        setupPageControl()
    }
    
    func setupPageViewController() {
        for item in splashSlide {
            let vc = SplashDetailViewController(splashSlide: item)
            viewControllers.append(vc)
        }
        
        addChild(pageViewController)
        pageViewController.setViewControllers([viewControllers[currentPage]], direction: .reverse, animated: true, completion: nil)
        pageViewController.view.frame.size = pageView.frame.size
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageView.addSubview(pageViewController.view)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = splashSlide.count
        pageControl.currentPage = currentPage
        pageControl.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    }
}

//MARK: PageViewControllerDatasource & delegate
extension SplashViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = viewControllers.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return viewControllers.last
            } else {
                return viewControllers[viewControllerIndex - 1]
            }
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = viewControllers.firstIndex(of: viewController) {
            if viewControllerIndex == viewControllers.count - 1 {
                return viewControllers.first
            } else {
                return viewControllers[viewControllerIndex + 1]
            }
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        currentPage = viewControllers.firstIndex(of: pageContentViewController)!
        pageControl.currentPage = currentPage
    }
}

struct SplashSlide {
    var image: UIImage
    var title: String
    var splashTitle: String
    
    init(image: UIImage,title: String, splashTitle: String) {
        self.image = image
        self.title = title
        self.splashTitle = splashTitle
    }
}

