import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_pay/flutter_google_pay.dart';

import '../simple_container.dart';
import '../simple_list_view.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Shop"),
        ),
        body: Builder(builder: (context) {
          scaffoldContext = context;
          return SimpleListView(
            children: [
              ...["T-shirt", "Ticket"]
                  .map<Widget>(
                      (item) => SimpleContainer(false, onPressed: () async {
                            await _makePayment(context);
                          }, children: [Text(item)]))
                  .toList()
            ],
          );
        }));
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {},
      ),
    ));
  }

  _makePayment(BuildContext context) async {
    var environment = 'rest';
    if (!(await FlutterGooglePay.isAvailable(environment))) {
      _showToast(context, 'Google pay not available');
    } else {
      PaymentItem pm = PaymentItem(
          stripeToken:
              'pk_test_51IrNxrCiU2RpHOAeUWrmNNdsTV5KR5bqIGyoHRYjfifoJ121xrkWHPVAcDe8azkmlvx3FVIkej1rpYEvhQGjCmFe00FYx0M5pv',
          stripeVersion: "2018-11-08",
          currencyCode: "usd",
          amount: "0.10",
          gateway: 'stripe');
      FlutterGooglePay.makePayment(pm).then((Result result) {
        if (result.status == ResultStatus.SUCCESS) {
          _showToast(context, 'Success');
        } else if (result.error != null) {
          _showToast(context, result.error);
        }
      }).catchError((error) {
        print('error');
        print(error);
      });
    }
  }

}
