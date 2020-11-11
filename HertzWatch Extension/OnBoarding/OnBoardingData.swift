struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(image: "Image", text: "A few minutes a day, every day.")
        model.newCard(image: "Image", text: "For best results, practice directly after waking, last thing before sleeping, and directly after exercise.")
        model.newCard(image: "Image", text: "Rest a finger on the top right of the display during practice to keep the display on.")

        return model
    }
}
