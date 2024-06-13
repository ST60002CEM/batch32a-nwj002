import 'package:liquor_ordering_system/features/onboarding/domain/entity/onboarding_entity.dart';

class OnboardingUseCase {
  List<OnboardingEntity> call() {
    return const [
      OnboardingEntity(
        title: 'Choose Your Favourite Drink',
        description:
            'Find your preferred beverage anytime, anywhere with ease.',
        imageUrl: 'assets/svg/chill.svg',
      ),
      OnboardingEntity(
        title: 'Grab a Drink to Refresh Yourself',
        description:
            'Whether it is a long day after work or game night, we are always here to refresh you.',
        imageUrl: 'assets/svg/ordering.svg',
      ),
      OnboardingEntity(
        title: 'Fastest Delivery Experience Ever',
        description: 'Because Chilled drinks always taste better.',
        imageUrl: 'assets/svg/deliver.svg',
      ),
    ];
  }
}
