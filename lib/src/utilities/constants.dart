import 'package:intl/intl.dart';
class Constants {
  static const String APP_TITLE = 'Service Package Calculator';
  static final List<int> nineTwelveMonths =[9,12];
  static final List<int> sixNineMonths =[6,9];
  static final List<int> sixMonth =[6];
  static final List<int> nineMonth =[9];
  static final List<int> twelveMonth =[12];
  static final List<int> empty =[0];
  //to get comma separated currency value
  static final oCcy =  NumberFormat("#,##0.00", "en_US");
  static final oCcy1 =  NumberFormat("#,##0", "en_US");
  static List<String> pageNames = [
    '',
    'Basic Job',
    'Standout Job',
    'Hot Job',
    'Bulk Subscription: Basic Job and CV Bank',
    'Bulk Subscription: Standout Job and CV Bank',
    'Bulk Subscription: Customized',
  ];
}
