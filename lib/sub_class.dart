import 'base.dart';
export 'base.dart' hide ProtectedBase;

class SubClass extends Base {
  int get doSomething => someHiddenStuff + somePublicStuff;
}
