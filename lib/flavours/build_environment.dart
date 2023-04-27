enum BuildFlavour { production, development }

class BuildEnvironment {
  final BuildFlavour flavour;

  BuildEnvironment({this.flavour = BuildFlavour.development});
}
