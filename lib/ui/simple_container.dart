import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleContainer extends StatelessWidget {
  final bool _isChecked;
  final List<Widget> children;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  SimpleContainer(this._isChecked,
      {this.children = const <Widget>[], this.onPressed, this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
          child: Container(
              margin: margin == null ? EdgeInsets.only(top: 10) : margin,
              padding: padding,
              decoration: BoxDecoration(
                color: _isChecked
                    ? Colors.indigoAccent.withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                  onPressed: () async {
                    if (onPressed != null) onPressed();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ))))
    ]);
  }
}
