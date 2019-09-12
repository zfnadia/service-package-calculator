// Imports the Flutter Driver API.
@Timeout(const Duration(hours: 1))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import 'package:test/test.dart';

void main() {
  int getAmount(int basicRate, int jobNum) {
    return basicRate * jobNum;
  }

  double getVat(double amount) {
    return amount * 0.05;
  }

  double getAmountToPay(double amount) {
    return amount + (amount * 0.05);
  }

  double getJobDiscount(int jobNum, String jobType) {
    List<double> discountForBasic = [
      0,
      25,
      40.9090909,
      43.1818182,
      44.5454546,
      50.9090909
    ];
    List<double> discountForPremium = [0, 25, 40, 43, 45, 51];
    print(discountForBasic[0]);

    if (jobType == 'Basic_Hot_Job') {
      print('Basic job er bhitore');
      if (jobNum > 0 && jobNum <= 5) {
        print('Basic job er bhitore 2');
        print(discountForBasic[(jobNum - 1)]);
        return discountForBasic[(jobNum - 1)];
      } else if (jobNum >= 6) {
        return discountForBasic[5];
      }
    } else if (jobType == 'Premium_Hot_Job') {
      if (jobNum > 0 && jobNum <= 5) {
        return discountForPremium[jobNum - 1];
      } else if (jobNum >= 6) {
        return discountForPremium[5];
      }
    }
    return 0;
  }

  double getDiscountedAmount(double discount, int jobNum, int basicRate) {
    if (discount == 0) {
      return jobNum * basicRate * 1.0;
    } else {
      return jobNum * basicRate * ((100 - discount) * 0.01);
    }
  }

  group('Service Package App', () {
    FlutterDriver driver;
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
    //hot job screen
    final hotJobIncFinder = find.byValueKey('hotJobInc');
    final hotJobDecFinder = find.byValueKey('hotJobDec');
    final hotJobAmntFinder = find.byValueKey('hotJobAmount');
    final hotJobSubTotalFinder = find.byValueKey('hotJobSubTotal');
    final hotJobVatFinder = find.byValueKey('hotJobVat');
    final hotJobPremIncFinder = find.byValueKey('hotJobPremInc');
    final hotJobPremDecFinder = find.byValueKey('hotJobPremDec');
    final hotJobPremiumAmntFinder = find.byValueKey('hotJobPremiumAmount');

    final int maxJobNumber = 10;
    int standoutSubTotal = 0;
    int hotJobBasicRate = 11000;
    int hotJobPremiumRate = 13500;
    double hotJobSubTotal = 0;

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
//.......................Basic Job Test.........................................

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

//............................Standout Job Test.................................
/*    test("Click item in the job list", () async {
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
    });*/

//.............................Hot Job Tests............................
    test("Click item in the job list", () async {
      await driver.tap(find.text(Constants.pageNames[3]));
      await driver.waitFor(find.text(Constants.pageNames[3]));
    });

    test('increment & decrement both hot job basic and premium jobs', () async {
      for (int hotJobIncCounter = 1;
          hotJobIncCounter <= maxJobNumber;
          hotJobIncCounter++) {
        double hotJobDiscountedBasic = getDiscountedAmount(
            getJobDiscount(hotJobIncCounter, 'Basic_Hot_Job'),
            hotJobIncCounter,
            hotJobBasicRate);
        print(
            'HOT JOB DISCOUNTED BASIC $hotJobDiscountedBasic JOB DISCOUNT ${getJobDiscount(hotJobIncCounter, 'Basic_Hot_Job')}');
        hotJobSubTotal = hotJobDiscountedBasic;
        await driver.tap(hotJobIncFinder);
        expect(await driver.getText(hotJobAmntFinder),
            '${Constants.oCcy.format(hotJobDiscountedBasic)} BDT');
        expect(await driver.getText(hotJobSubTotalFinder),
            '${Constants.oCcy.format(hotJobSubTotal)} BDT');
        expect(await driver.getText(hotJobVatFinder),
            '${Constants.oCcy.format(getVat(hotJobSubTotal))} BDT');
        expect(await driver.getText(amountToPayFinder),
            '${Constants.oCcy.format(getAmountToPay(hotJobSubTotal))} BDT');

        if (hotJobIncCounter == maxJobNumber) {
          for (int hotJobPremIncCounter = 1;
              hotJobPremIncCounter <= maxJobNumber;
              hotJobPremIncCounter++) {
            double hotJobDiscountedPremium = getDiscountedAmount(
                getJobDiscount(hotJobPremIncCounter, 'Premium_Hot_Job'),
                hotJobPremIncCounter,
                hotJobPremiumRate);
            hotJobSubTotal = hotJobSubTotal + hotJobDiscountedPremium;
            await driver.tap(hotJobPremIncFinder);
            expect(await driver.getText(hotJobPremiumAmntFinder),
                '${Constants.oCcy.format(hotJobDiscountedPremium)} BDT');
            expect(await driver.getText(hotJobSubTotalFinder),
                '${Constants.oCcy.format(hotJobSubTotal)} BDT');
            expect(await driver.getText(hotJobVatFinder),
                '${Constants.oCcy.format(getVat(hotJobSubTotal))} BDT');
            expect(await driver.getText(amountToPayFinder),
                '${Constants.oCcy.format(getAmountToPay(hotJobSubTotal))} BDT');

            hotJobSubTotal = hotJobSubTotal - hotJobDiscountedPremium;

            if (hotJobPremIncCounter == maxJobNumber) {
              for (int hotJobPremDecCounter = hotJobPremIncCounter - 1;
                  hotJobPremDecCounter >= 0;
                  hotJobPremDecCounter--) {
                double hotJobDiscountedPremium = getDiscountedAmount(
                    getJobDiscount(hotJobPremDecCounter, 'Premium_Hot_Job'),
                    hotJobPremDecCounter,
                    hotJobPremiumRate);
                hotJobSubTotal = hotJobSubTotal + hotJobDiscountedPremium;
                await driver.tap(hotJobPremDecFinder);
                expect(await driver.getText(hotJobPremiumAmntFinder),
                    '${Constants.oCcy.format(hotJobDiscountedPremium)} BDT');
                expect(await driver.getText(hotJobVatFinder),
                    '${Constants.oCcy.format(getVat(hotJobSubTotal))} BDT');
                expect(await driver.getText(amountToPayFinder),
                    '${Constants.oCcy.format(getAmountToPay(hotJobSubTotal))} BDT');

                hotJobSubTotal = hotJobSubTotal - hotJobDiscountedPremium;

                if (hotJobPremDecCounter == 0) {
                  for (int hotJobDecCounter = hotJobIncCounter - 1;
                      hotJobDecCounter >= 0;
                      hotJobDecCounter--) {
                    double hotJobDiscountedBasic = getDiscountedAmount(
                        getJobDiscount(hotJobDecCounter, 'Basic_Hot_Job'),
                        hotJobDecCounter,
                        hotJobBasicRate);
                    hotJobSubTotal = hotJobDiscountedBasic;
                    await driver.tap(hotJobDecFinder);
                    expect(await driver.getText(hotJobAmntFinder),
                        '${Constants.oCcy.format(hotJobDiscountedBasic)} BDT');
                    expect(await driver.getText(hotJobVatFinder),
                        '${Constants.oCcy.format(getVat(hotJobSubTotal))} BDT');
                    expect(await driver.getText(amountToPayFinder),
                        '${Constants.oCcy.format(getAmountToPay(hotJobSubTotal))} BDT');
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
