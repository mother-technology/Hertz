struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "Hertz-24@2x.png", text: "A few minutes a day, every day.")
        model.newCard(image: "xmark.circle.fill", text: "For best results, practice directly after waking, last thing before sleeping, and directly after exercise.")
        model.newCard(image: "Image", text: "Rest a finger on the top right of the display during practice to keep the display on.")
        model.newCard(image: "Image", text: "Give the digital crown a twist to find a comfy speed.")
        return model
    }
}
