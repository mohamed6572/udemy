import 'package:gps_tracker/modules/Shop_App/Login/shop_login_screan.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';

void SignOut(context) {
  casheHelper.removeData(key: 'token').then((value) {
          if(value){
            navigateToAndFinish(context, ShopLoginScrean());
          }
        });
}

void printFullText(String text)
{
 final pattern = RegExp('.{1,800}') ; //800 is the size of each chunk
 pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
String? token='';
String? uId='';