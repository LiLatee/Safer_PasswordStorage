import 'package:flutter/material.dart';

double getWidth({BuildContext context}) => MediaQuery.of(context).size.width;
double getHeight({BuildContext context}) => MediaQuery.of(context).size.height;
double getPercentOfWidth({BuildContext context, double percent}) => MediaQuery.of(context).size.width*percent;
double getPercentOfHeight({BuildContext context, double percent}) => MediaQuery.of(context).size.height*percent;
