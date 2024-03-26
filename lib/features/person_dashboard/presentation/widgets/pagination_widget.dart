import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

mixin PaginationMixin<T> {
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

  bool displayNextArrow({required NumberPaginatorController controller}) {
    return controller.currentPage <= totalPage - 1;
  }

  bool displayPreviousArrow({required NumberPaginatorController controller}) {
    return controller.currentPage >= initialPage;
  }

  void goToFirstPage({required NumberPaginatorController controller}) {
    if (controller.currentPage >= 0) {
      displayedItems = getDisplayedList(0);
      print(initialPage);
      controller.currentPage = 0;
      controller.navigateToPage(initialPage);
    }
  }

  void goToLastPage({required NumberPaginatorController controller}) {
    if (controller.currentPage < totalPage - 1 &&
        totalPage >= 1) {
      displayedItems = getDisplayedList(
        totalPage - 1,
      );
      controller.navigateToPage(totalPage - 1);
    }
  }

  void goToPage(
      {required NumberPaginatorController controller, required int page}) {
    if (page >= 0 && page < totalPage) {
      displayedItems = getDisplayedList(page);
      controller.currentPage = page;
    }
  }
}

class PaginationWidget<T extends PaginationMixin> extends StatelessWidget {
  final T cubit;
  final NumberPaginatorController numberPaginatorController =
      NumberPaginatorController();
  PaginationWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: cubit.displayPreviousArrow(
                  controller: numberPaginatorController)
              ? () => cubit.goToFirstPage(controller: numberPaginatorController)
              : null,
          icon: const Icon(Icons.keyboard_double_arrow_left),
        ),
        Expanded(
          child: NumberPaginator(
            controller: numberPaginatorController,
            numberPages: cubit.totalPage,
            initialPage: cubit.initialPage,
            onPageChange: (value) => cubit.goToPage(
                controller: numberPaginatorController, page: value),
          ),
        ),
        IconButton(
          onPressed: cubit.displayNextArrow(
                  controller: numberPaginatorController)
              ? () => cubit.goToLastPage(controller: numberPaginatorController)
              : null,
          icon: const Icon(Icons.keyboard_double_arrow_right),
        )
      ],
    );
  }
}
