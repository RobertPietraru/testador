@Deprecated('Better use DefaultValues.forStrings')
const mockValueForDefault = 'nothing-to-see-here!@#^';

class DefaultValues {
  static const String forStrings = 'nothing-to-see-here!@#^';
  // bad approach for complex projects, but here, where usually ints are just indexes of questions and stuff, it's not actually that bad
  static const int forInts = 1203971230198237412;
}
