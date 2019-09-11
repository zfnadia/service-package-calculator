// Imports the Flutter Driver API.
@Timeout(const Duration(hours: 1))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import 'package:test/test.dart';

void main() {
  int getAmount(int basicRate, int jobNum) {
    return basicRate * jobNum;
  }

  double getVat(int amount) {
    return amount * 0.05;
  }

  double getAmountToPay(int amount) {
    return amount + (amount * 0.05);
  }

  group('Service Package App', () {
    //basic job screen
    final incButtonFinder = find.byValueKey('basicInc');
    final decButtonFinder = find.byValueKey('basicDec');
    final amountFinder = find.byValueKey('basicAmount');
    final vatFinder = find.byValueKey('basicVat');
    final amountToPayFinder = find.byValueKey('total amount');
    //standout job screen
    final standoutIncFinder = find.byValueKey('standoutInc');
    final standoutDecFinder = find.byValueKey('standoutDec');
    final standoutAmntFinder = find.byValueKey('standoutAmount');
    final standoutSubTotalFinder = find.byValueKey('standoutSubTotal');
    final standoutVatFinder = find.byValueKey('standoutVat');
    final standoutPremIncFinder = find.byValueKey('standoutPremInc');
    final standoutPremDecFinder = find.byValueKey('standoutPremDec');
    final standoutPremiumAmntFinder = find.byValueKey('standoutPremiumAmount');

    final int maxJobNumber = 10;
    int standoutSubTotal = 0;

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

/*    test("Click item in the job list", () async {
      await driver.tap(find.text(Constants.pageNames[1]));
      await driver.waitFor(find.text(Constants.pageNames[1]));
    });

    test('increments & decrements the counter', () async {
      int basicRate = 2950;
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
    });*/

    test("Click item in the job list", () async {
      await driver.tap(find.text(Constants.pageNames[2]));
      await driver.waitFor(find.text(Constants.pageNames[2]));
    });

    test('increment & decrement both standout basic and premium jobs',
        () async {
      int standoutBasicRate = 3900;

      for (int standoutIncCounter = 1;
          standoutIncCounter <= maxJobNumber;
          standoutIncCounter++) {
        standoutSubTotal = standoutSubTotal + standoutBasicRate;
        await driver.tap(standoutIncFinder);
        expect(await driver.getText(standoutAmntFinder),
            '${Constants.oCcy.format(getAmount(standoutBasicRate, standoutIncCounter))} BDT');
        expect(await driver.getText(standoutSubTotalFinder),
            '${Constants.oCcy.format(standoutSubTotal)} BDT');
        expect(await driver.getText(standoutVatFinder),
            '${Constants.oCcy.format(getVat(standoutSubTotal))} BDT');
        expect(await driver.getText(amountToPayFinder),
            '${Constants.oCcy.format(getAmountToPay(standoutSubTotal))} BDT');

        if (standoutIncCounter == maxJobNumber) {
          int standoutPremiumRate = 4900;
          for (int standoutPremIncCounter = 1;
              standoutPremIncCounter <= maxJobNumber;
              standoutPremIncCounter++) {
            standoutSubTotal = standoutSubTotal + standoutPremiumRate;
            await driver.tap(standoutPremIncFinder);
            expect(await driver.getText(standoutPremiumAmntFinder),
                '${Constants.oCcy.format(getAmount(standoutPremiumRate, standoutPremIncCounter))} BDT');
            expect(await driver.getText(standoutSubTotalFinder),
                '${Constants.oCcy.format(standoutSubTotal)} BDT');
            expect(await driver.getText(standoutVatFinder),
                '${Constants.oCcy.format(getVat(standoutSubTotal))} BDT');
            expect(await driver.getText(amountToPayFinder),
                '${Constants.oCcy.format(getAmountToPay(standoutSubTotal))} BDT');

            if (standoutPremIncCounter == maxJobNumber) {
              for (int standoutPremDecCounter = standoutPremIncCounter - 1;
                  standoutPremDecCounter >= 0;
                  standoutPremDecCounter--) {
                standoutSubTotal = standoutSubTotal - standoutPremiumRate;
                await driver.tap(standoutPremDecFinder);
                expect(await driver.getText(standoutPremiumAmntFinder),
                    '${Constants.oCcy.format(getAmount(standoutPremiumRate, standoutPremDecCounter))} BDT');
                expect(await driver.getText(standoutVatFinder),
                    '${Constants.oCcy.format(getVat(standoutSubTotal))} BDT');
                expect(await driver.getText(amountToPayFinder),
                    '${Constants.oCcy.format(getAmountToPay(standoutSubTotal))} BDT');

                if (standoutPremDecCounter == 0) {
                  for (int standoutDecCounter = standoutIncCounter - 1;
                      standoutDecCounter >= 0;
                      standoutDecCounter--) {
                    standoutSubTotal = standoutSubTotal - standoutBasicRate;
                    await driver.tap(standoutDecFinder);
                    expect(await driver.getText(standoutAmntFinder),
                        '${Constants.oCcy.format(getAmount(standoutBasicRate, standoutDecCounter))} BDT');
                    expect(await driver.getText(standoutVatFinder),
                        '${Constants.oCcy.format(getVat(standoutSubTotal))} BDT');
                    expect(await driver.getText(amountToPayFinder),
                        '${Constants.oCcy.format(getAmountToPay(standoutSubTotal))} BDT');
                  }
                }
              }
            }
          }
        }
      }
    });
  }, timeout: Timeout(Duration(hours: 3)));
}
