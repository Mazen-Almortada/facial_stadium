class OnboardingItem {
  final String title;
  final String discription;
  OnboardingItem({
    required this.title,
    required this.discription,
  });
}

List<OnboardingItem> onboardingContentsList = [
  OnboardingItem(
      title: "Access the stadium seamlessly using facial recognition.",
      discription:
          "Enter and enjoy events in the stadium swiftly and securely with facial recognition technology"),
  OnboardingItem(
      title: "We take  your safety seriously in the App as well",
      discription:
          "With our Multi-Factor Authentication, you’re in safe hands with us.")
];
