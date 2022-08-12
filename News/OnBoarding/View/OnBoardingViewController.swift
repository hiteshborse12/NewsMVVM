//
//  OnBoardingViewController.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit
import iOSDropDown
class OnBoardingViewController: UIViewController {

    var viewModel: OnBoardingViewModelProtocol?
    
    //MARK: @IBOutlet
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var countryDropDown: DropDown!
    @IBOutlet weak var startButton: CustomButton!
    
    //MARK: Init
    init(viewModel: OnBoardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    //MARK: SetupView
    private func setupView(){
        self.navigationItem.backButtonTitle = StringConstants.backTitle
        self.title = StringConstants.onboardingTitle
        self.setupCategoryDropDown()
        self.setupCountryDropDown()
        }
    
    private func setupCategoryDropDown(){
        self.categoryDropDown.optionArray = viewModel?.getCategories() ?? []
        self.categoryDropDown.didSelect{(selectedText , index ,id) in
            self.viewModel?.selectedCategoryIndex = index
            }
    }
    private func setupCountryDropDown(){
        self.countryDropDown.optionArray = viewModel?.getCountries() ?? []
        self.countryDropDown.didSelect{(selectedText , index ,id) in
            self.viewModel?.selectedCountryIndex = index
            }
    }
    //MARK: - Actions
    @IBAction private func startButonAction(_ sender: CustomButton) {
        self.viewModel?.startWithSelectedCategoryCountry()
    }
}
//MARK: Bind viewModel
extension OnBoardingViewController {
    private func bindViewModel(){
        viewModel?.moveToNewsListVc = { [weak self] in
            guard let userSelectedCategoryCountry = self?.viewModel?.userSelectedCategoryCountry else { return }
            let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, dataSource: NewsListDataProvider())
            let newsListViewController = NewsListViewController(viewModel: newsListViewModel)
            self?.push(viewController: newsListViewController)
        }
    }
}

