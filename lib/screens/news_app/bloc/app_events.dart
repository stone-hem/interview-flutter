abstract class AppEvent{
  const AppEvent();
}

class ChangeIndexEvent extends AppEvent{
  final int index;
  const ChangeIndexEvent(this.index):super();
}