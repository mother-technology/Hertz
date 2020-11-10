struct OnBoardingData {
    static func build() -> OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(title: "Test", image: "Image", text: "Alot of text just slipping on by ad by")
        model.newCard(title: "Test2", image: "Image", text: "adadad ad adad adAlot of text just slipping on by ad by")
        model.newCard(title: "Test3", image: "Image", text: "Aloasd d asdadadad ddadasdadt of text just slipping on by ad by")

        return model
    }
}
