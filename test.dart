// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, prefer_typing_uninitialized_variables

import 'dart:math' as math;

class Point with Drawable{
  static var existedPoint;

  num x = 0, y = 0;

  Point.origin(this.x, this.y){
    existedPoint ??= this;
  }

  factory Point.useExisted(bool use, {num valX=0, num valY=0}){
    return use ? existedPoint : Point.origin(valX, valY);
  }

  @override
  String toString() => 'Point: $x, $y';
}

class Circle extends Point with Drawable{
  num radius;

  Circle(num x, num y, this.radius) : super.origin(x, y);
  
  num get square => (math.pi * math.pow(radius, 2));
  set square(num val) => radius = math.sqrt(val / math.pi);

  @override
  String toString() => 'Circle: $x, $y, $radius';
}

mixin Drawable{
  bool _drawable = true;

  bool get drawable => _drawable;
  set drawable(val) => _drawable = val;

  void draw(){
    print('Drawing...');
  }
  
  void erase(){
    print('Erasing...');
  }
}

Function customPiSquare(num pi) => (num r) => pi * math.pow(r, 2);

void main() {
  //setter and getter
  var p = Point.origin(1, 2);
  var c = Circle(2, 2, 3);
  assert(c.radius == 3); 
  assert(c.x == 2); 
  c.square = 15;
  assert(c.radius == math.sqrt(15 / math.pi));

  //lambda and closure
  var addFunction = (a, b) => a+b;
  print('Result of addFunction: ${addFunction(1, 2)}');
  var f = customPiSquare(3);
  var circle = Circle(1, 2, 3);
  print(f(circle.radius));

  //constructor factory
  var newPoint = Point.useExisted(true);
  print(newPoint);

  var newPoint2 = Point.useExisted(false, valX: 0, valY: 9);
  print(newPoint2);
  
  //mixin
  print('Circle drawable before set: ${circle.drawable}');
  circle.drawable = false;
  print('Circle drawable after set: ${circle.drawable}');

  var point = Point.origin(1, 2);
  print('Point drawable before set: ${point.drawable}');
  point.drawable = false;
  print('Point drawable after set: ${point.drawable}');
  
  Circle(0, 0, 1)
    ..draw()
    ..erase();

  
  
  //collections
  var list = [circle, circle, point];
  for (var obj in list){
    print(obj);
  }
  assert(list.length == 3);
  list.addAll([point, point, point]);
  assert(list.length == 6);
  
  var set = list.toSet();
  assert(set.length == 2);

  var map = {0: circle, 1: point};
  print('Map[0]: ${map[0]}');

  print('All x coordinates > 0? ${list.every((point) => point.x > 0)}');
}