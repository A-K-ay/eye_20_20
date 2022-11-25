class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel(this.imagePath, this.title, this.description);
}

List<OnboardingModel> onboardingModelList = [
  OnboardingModel("assets/images/co-working.svg", "Take Care Of Your Eyes",
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here"),
  OnboardingModel("assets/images/screen_time.svg", "Take Care Of Your Eyes",
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here"),
  OnboardingModel("assets/images/starry_window.svg", "Take Care Of Your Eyes",
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here"),
];
