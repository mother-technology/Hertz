struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "w-app-screen-1", text: "Focus on the red dot.")
        model.newCard(image: "w-app-screen-2", text: "As the dot passes over blue ticks, breath in through your nose.")
        model.newCard(image: "w-app-screen-3", text: "As it passes the white tick, pause your breathing without tensing.")
        model.newCard(image: "w-app-screen-4", text: "As the dot passes over the brown tick marks, slowly breath out through your nose, empty your lungs from the top down, drop your shoulders and relax.")
        model.newCard(image: "onboarding-chart", text: "Swipe down to access your results.")
        model.newCard(image: "onboarding-finger", text: "Rest a finger on the top right of the display during practice to keep the display on.")
        model.newCard(image: "onboarding-crown", text: "Give the digital crown a twist to find a comfortable speed.")
        model.newCard(image: "onboarding-use", width: 104.4, height: 42.0, text: "For best results, practice straight after waking, directly after exercise and just before sleeping.")

        return model
    }
}
