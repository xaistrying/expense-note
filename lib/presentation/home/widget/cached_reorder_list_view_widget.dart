import 'package:flutter/material.dart';

typedef ListItemWidgetBuilder<T> =
    Widget Function(BuildContext context, T item);

class CachedReorderableListView<T> extends StatefulWidget {
  const CachedReorderableListView({
    required this.list,
    required this.itemBuilder,
    required this.onUpdate,
    super.key,
    this.padding,
  });

  final List<T> list;
  final ListItemWidgetBuilder<T> itemBuilder;
  final Function onUpdate;
  final EdgeInsets? padding;

  @override
  CachedReorderableListViewState<T> createState() =>
      CachedReorderableListViewState<T>();
}

class CachedReorderableListViewState<T>
    extends State<CachedReorderableListView<T>> {
  late List<T> list;

  @override
  void initState() {
    list = [...widget.list];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CachedReorderableListView<T> oldWidget) {
    if (widget.list != oldWidget.list) {
      list = [...widget.list];
    }
    super.didUpdateWidget(oldWidget);
  }

  void updateList(List<T> value) {
    setState(() {
      list = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      proxyDecorator: (child, index, animation) => child,
      itemCount: list.length,
      itemBuilder: (context, index) => widget.itemBuilder(context, list[index]),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = list.removeAt(oldIndex);
          list.insert(newIndex, item);
        });
        widget.onUpdate(list);
      },
      padding: widget.padding,
    );
  }
}
