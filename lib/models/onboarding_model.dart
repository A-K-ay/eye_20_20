class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel(this.imagePath, this.title, this.description);
}

List<OnboardingModel> onboardingModelList = [
  OnboardingModel(
      "assets/images/co-working.svg",
      "Eye Care Plus: A smart app for healthy eyesight",
      "Protect your eyes from screen fatigue and improve your vision with Eye Care Plus"),
  OnboardingModel("assets/images/screen_time.svg", "How Eye Care Plus works",
      "Follow the 20-20-20 rule, customize your breaks, and get personalized reminders from Eye Care Plus"),
  OnboardingModel(
      "assets/images/starry_window.svg",
      "Benefits of using Eye Care Plus",
      "Reduce eye strain, prevent eye diseases, and enhance your productivity and well-being with Eye Care Plus."),
];
