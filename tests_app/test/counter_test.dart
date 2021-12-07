import 'package:flutter_test/flutter_test.dart';
import 'package:tests_app/counter.dart';

void main(List<String> args) {
  // Needs the "test" package as a dev dependency.
  test("Counter value should be incremented", () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
