struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "onboarding-chart", text: "Swipe down to access your results.")
        model.newCard(image: "onboarding-use", width: 120.0, height: 42.0, text: "For best results, practice straight after waking, just before sleeping, and directly after exercise.")
        model.newCard(image: "onboarding-finger", text: "Rest a finger on the top right of the display during practice to keep the display on.")
        model.newCard(image: "onboarding-crown", text: "Give the digital crown a twist to find a comfortable speed.")
        return model
    }
}
