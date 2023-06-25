import 'package:flutter_riverpod/flutter_riverpod.dart';


final pageIndexNotifierProvider =
    AsyncNotifierProvider<PageIndexSelectorNotifier, PageIndexMode>(() {
  return PageIndexSelectorNotifier();
});

class PageIndexMode {
  int indexValue= 0;
  int get index => indexValue;
}


class PageIndexSelectorNotifier extends AsyncNotifier<PageIndexMode> {
  final PageIndexMode _pageMode = PageIndexMode();
  

  void changeIndex(int value) {
    _pageMode.indexValue = value;
    state = AsyncData(_pageMode);
  }

  
  @override
  build() {
    return _pageMode;
  }
}