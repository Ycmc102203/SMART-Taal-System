class FormTwoArguments {
  final DateTime passedDate;
  final String passedEnumerator;
  final String passedFishingGround;
  final String passedLandingCenter;
  final String passedTotalLandings;
  final String passedBoatName;
  final String passedFishingGear;
  final String passedFishingEffort;
  final String passedTotalBoatCatch;
  final String passedSampleSerialNumber;
  final String passedTotalSampleWeight;

  FormTwoArguments(
      this.passedDate,
      this.passedEnumerator,
      this.passedFishingGround,
      this.passedLandingCenter,
      this.passedTotalLandings,
      this.passedBoatName,
      this.passedFishingGear,
      this.passedFishingEffort,
      this.passedTotalBoatCatch,
      this.passedSampleSerialNumber,
      this.passedTotalSampleWeight);
}

class FormOneArguments {
  final DateTime passedDate;
  final firstName;
  final lastName;
  FormOneArguments(this.passedDate, this.firstName, this.lastName);
}
