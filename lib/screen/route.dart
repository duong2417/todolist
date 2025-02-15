import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'todo_screen.dart/homepage.dart';

class ROUTE{
static String splashSCREEN="splash";
static String todoSCREEN="todo";
static String taskSCREEN="task";

static Route<dynamic>? onGenerateROUTE(RouteSettings settings){
  if(settings.name==splashSCREEN){
return splashROUTE();
  }
  else if(settings.name==todoSCREEN){
  return MaterialPageRoute(builder:(BuildContext context)=> const TodoSCREEN());
  }  else if(settings.name==taskSCREEN){
  // return MaterialPageRoute(builder:(BuildContext context)=> const TaskSCREEN());
  }
  return null;
}

static Route<dynamic> splashROUTE(){
  return MaterialPageRoute(builder:(BuildContext context)=> const SplashSCREEN());
}
}