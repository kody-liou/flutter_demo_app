// Declare the base and provide extensions for "protected" members:
abstract class Base {
  int get _someHiddenStuff => 42;
  int get somePublicStuff => 37;
}

extension ProtectedBase on Base {
  int get someHiddenStuff => _someHiddenStuff;
}
