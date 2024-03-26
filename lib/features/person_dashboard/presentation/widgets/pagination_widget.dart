import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

mixin PaginationMixin<T> {
  NumberPaginatorController numberPaginatorController = NumberPaginatorController();
  late int totalPage;
  late int initialPage;
  late List<T>? displayedItems;
  late List<T>? items;
  late int itemsPerPage;

  void defineTotalPageNum({required List<T> items}) {
    totalPage = (items.length / itemsPerPage).ceil();
    displayedItems = getDisplayedList(initialPage);
  }

  List<T> getDisplayedList(int page) {
    final startIndex = page * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    List<T> tempItems = items!.sublist(
        startIndex, endIndex > items!.length ? items!.length : endIndex);

    if (endIndex > items!.length) {
      tempItems = items!.sublist(startIndex, items!.length);
    }

    return tempItems;
  }

  void goToLastPage() {
    if (numberPaginatorController.currentPage < totalPage - 1 && totalPage >= 1) {
      displayedItems = getDisplayedList(
        totalPage - 1,
      );
      numberPaginatorController.currentPage = totalPage - 1;
    }
  }

  bool displayNextArrow() {
    return numberPaginatorController.currentPage <= totalPage - 1;
  }

  bool displayPreviousArrow() {
    return numberPaginatorController.currentPage >= initialPage;
  }

  void goToFirstPage() {
    if (numberPaginatorController.currentPage >= 0) {
      displayedItems = getDisplayedList(0);
      numberPaginatorController.currentPage = 0;
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPage) {
      displayedItems = getDisplayedList(page);
      numberPaginatorController.currentPage = page;
    }
  }
}

class PaginationWidget<T extends PaginationMixin> extends StatelessWidget {
  final T cubit;

  const PaginationWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed:
              cubit.displayPreviousArrow() ? () => cubit.goToFirstPage() : null,
          icon: const Icon(Icons.keyboard_double_arrow_left),
        ),
        Expanded(
          child: NumberPaginator(
            controller: cubit.numberPaginatorController,
            numberPages: cubit.totalPage,
            initialPage: cubit.initialPage,
            onPageChange: (value) => cubit.goToPage(value),
          ),
        ),
        IconButton(
          onPressed:
              cubit.displayNextArrow() ? () => cubit.goToLastPage() : null,
          icon: const Icon(Icons.keyboard_double_arrow_right),
        )
      ],
    );
  }
}
