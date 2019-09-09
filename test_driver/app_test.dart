// Imports the Flutter Driver API.
@Timeout(const Duration(hours: 1))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import 'package:test/test.dart';

void main() {
  group('Service Package App', () {
    final incButtonFinder = find.byValueKey('increment');
    final decButtonFinder = find.byValueKey('decrement');
    final amountFinder = find.byValueKey('Amount');
    final vatFinder = find.byValueKey('VAT (5%)');
    final amountToPayFinder = find.byValueKey('total amount');

    final int maxJobNumber = 200;

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("Click item in the job list", () async {
      await driver.tap(find.text(Constants.pageNames[1]));
      await driver.waitFor(find.text(Constants.pageNames[1]));
    });

    test('increments & decrements the counter', () async {
      int basicRate = 2950;
      int getAmount(int basicRate, int jobNum) {
        return basicRate * jobNum;
      }

      double getVat(int amount) {
        return amount * 0.05;
      }

      double getAmountToPay(int amount) {
        return amount + (amount * 0.05);
      }

      for (int i = 1; i <= maxJobNumber; i++) {
        await driver.tap(incButtonFinder);
        expect(await driver.getText(amountFinder),
            '${Constants.oCcy.format(getAmount(basicRate, i))} BDT');
        expect(await driver.getText(vatFinder), '${Constants.oCcy.format(getVat(getAmount(basicRate, i)))} BDT');
        expect(await driver.getText(amountToPayFinder), '${Constants.oCcy.format(getAmountToPay(getAmount(basicRate, i)))} BDT');
        if(i == maxJobNumber){
          for (int j = i-1; j >= 0; j--) {
            await driver.tap(decButtonFinder);
            expect(await driver.getText(amountFinder),
                '${Constants.oCcy.format(getAmount(basicRate, j))} BDT');
            expect(await driver.getText(vatFinder), '${Constants.oCcy.format(getVat(getAmount(basicRate, j)))} BDT');
            expect(await driver.getText(amountToPayFinder), '${Constants.oCcy.format(getAmountToPay(getAmount(basicRate, j)))} BDT');
          }
        }
      }
    });
  }, timeout: Timeout(Duration(hours: 3)));
}

