import 'package:flutter/material.dart';

double getWidth({required BuildContext context}) => MediaQuery.of(context).size.width;
double getHeight({required BuildContext context}) => MediaQuery.of(context).size.height;
double getPercentOfWidth({required BuildContext context, required double percent}) => MediaQuery.of(context).size.width*percent;
double getPercentOfHeight({required BuildContext context, required double percent}) => MediaQuery.of(context).size.height*percent;
