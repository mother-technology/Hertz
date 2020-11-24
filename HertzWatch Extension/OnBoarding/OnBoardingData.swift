struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "onboarding-chart", text: "Swipe down to access your results.")
        model.newCard(image: "onboarding-finger", text: "Rest a finger on the screen to keep the display on.")
        model.newCard(image: "onboarding-crown", text: "Twist the digital crown to adjust speed.")
        model.newCard(image: "onboarding-use", width: 140.0, height: 50.0, text: "Practice directly after waking, exercise and just before sleeping.")

        return model
    }
}
