import 'package:objd/core.dart';

/// This Loop repeats a set of widget as long/until a condition is/becomes true.
/// The Loop uses a Grouped File and Recursion to repeat commands.
class Do extends RestActionAble {
  Condition cond;
  bool testBefore;
  bool _isWhile;
  List<Widget> then;

/// This Loop repeats a set of widget as long a condition is true.
/// The Loop uses a Grouped File and Recursion to repeat commands.
///
/// | Do.While|  |
/// |--|--|
/// |Condition or conditional value| a condition to test for each iteration |
/// |then| a List of Widgets to execute each time |
/// |testBefore| test before entering the loop if condition is true(optional) |
  Do.While(dynamic condition,{this.testBefore = true,this.then}){
    _setValues(true, condition);
  }
/// This Loop repeats a set of widget until a condition becomes true.
/// The Loop uses a Grouped File and Recursion to repeat commands.
///
/// | Do.Until|  |
/// |--|--|
/// |Condition or conditional value| a condition to test for each iteration |
/// |then| a List of Widgets to execute each time |
/// |testBefore| test before entering the loop if condition is false(optional) |
  Do.Until(dynamic condition,{this.testBefore = true,this.then}){
    _setValues(false, condition);
  }
  _setValues(iswhile,condition){
    _isWhile = iswhile;
    if(condition is Condition) cond = condition;
    else cond = new Condition(condition);
  }

  @override
  Widget generate(Context context) {
    if(!_isWhile){
      cond = Condition.not(cond);
    }
    then.add(If(cond,Then:[File.recursive()]));
    Group gr = Group(
      filename: "doloop",
      children: then,
      groupMin: 0
    );
    if(testBefore) return If(cond,Then:[gr]);
    return gr;
  }
}