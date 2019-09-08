// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import 'package:test/test.dart';

void main() {

  final timeout = Duration(seconds: 160);

  group('Service Package App', () {
//    final counterTextFinder = find.byValueKey('counter');
    final incButtonFinder = find.byValueKey('increment');
//    final decButtonFinder = find.byValueKey('decrement');
    final amountFinder = find.byValueKey('Amount');
    final vatFinder = find.byValueKey('VAT (5%)');
    final amountToPayFinder = find.byValueKey('total amount');

    FlutterDriver driver;


    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(
//        isolateReadyTimeout: timeout,
//        printCommunication: true,
      );
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("Click list item in the job list", () async {
      await driver.tap(find.text(Constants.pageNames[1]));
      await driver.waitFor(find.text(Constants.pageNames[1]));
    });

    test('increments the counter', () async {
      int basicRate = 2950;
      int getAmount(int basicRate, int jobNum) {
        return basicRate * jobNum;
      }
      double getVat(int amount) {
        return basicRate * 0.05;
      }
      double getAmountToPay(int amount) {
        return amount + (amount * 0.05);
      }
      // First, tap the button.
      for (int i = 1; i <= 100; i++) {
        await driver.clearTimeline(timeout: Duration(minutes: 1));
        await driver.tap(incButtonFinder);
        expect(await driver.getText(amountFinder), '${Constants.oCcy.format(getAmount(basicRate, i))}  BDT');

//        expect(await driver.getText(vatFinder), '${Constants.oCcy.format(getVat(getAmount(basicRate, i)))}  BDT');
//        expect(await driver.getText(amountToPayFinder), '${Constants.oCcy.format(getAmountToPay(getAmount(basicRate, i))).toString()}  BDT');

      }
      // Then, verify the counter text is incremented by 1.
    //  expect(await driver.getText(counterTextFinder), "1");
    });

  });


}