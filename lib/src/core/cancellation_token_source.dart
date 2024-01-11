part of '../core.dart';

class CancellationTokenSource {
  bool _cancelled;
  bool get cancelled => _cancelled;

  CancellationTokenSource() : _cancelled = false;

  void cancel() {
    _cancelled = true;
  }
}
