struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "hz", text: "Focus on the red dot. Breath in as it passes blue ticks, arrest your breathing over white ticks, and breath out over dark red ticks.")
        model.newCard(image: "onboarding-finger", text: "Swipe up to access instructions.")
        model.newCard(image: "onboarding-crown", text: "Occasionally nudge the digital crown to keep the display active.")
        model.newCard(image: "csd-red", width: 100, height: 23, text: "Read more at www.csd.red")
//        model.newCard(image: "onboarding-use", width: 140.0, height: 50.0, text: "Practice directly after waking, exercise and just before sleeping.")

        return model
    }
}
