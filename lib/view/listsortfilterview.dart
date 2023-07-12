import 'package:flutter/material.dart';

class Item {
  final String name;
  final String model;
  final String status;
  bool isFavorite;

  Item(
      {required this.name,
      required this.model,
      required this.status,
      this.isFavorite = false});
}

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Item> itemList = [
    Item(name: "kumar", model: "Model X", status: "Active", isFavorite: false),
    Item(name: "kavi", model: "Model Y", status: "Inactive", isFavorite: true),
    Item(name: "arun", model: "Model Z", status: "Active", isFavorite: false),
    Item(name: "Akil", model: "Model X", status: "Active", isFavorite: false),
    Item(name: "bala", model: "Model Y", status: "Inactive", isFavorite: true),
    Item(
        name: "saravana", model: "Model Z", status: "Active", isFavorite: true),
    Item(
        name: "prasanth",
        model: "Model X",
        status: "Active",
        isFavorite: false),
    Item(name: "Amar", model: "Model Y", status: "Inactive", isFavorite: true),
    Item(
        name: "zaganlhi",
        model: "Model Z",
        status: "Active",
        isFavorite: false),
    Item(name: "gows", model: "Model X", status: "Active", isFavorite: true),
    Item(name: "guna", model: "Model Y", status: "Inactive", isFavorite: true),
    Item(
        name: "ironman", model: "Model Z", status: "Active", isFavorite: false),
  ];
  List<Item> filteredList = [];
  bool isAscending = true;
  bool showFavoritesOnly = false;
  String searchQuery = '';
  List<String> selectedStatuses = [];
  List<String> selectedModels = [];

  @override
  void initState() {
    super.initState();
    filteredList = itemList;
  }

  void toggleFavorite(int index) {
    setState(() {
      itemList[index].isFavorite = !itemList[index].isFavorite;
    });
  }

  void searchItems(String query) {
    setState(() {
      searchQuery = query;
      filterItems();
    });
  }

  void filterItems() {
    setState(() {
      filteredList = itemList.where((item) {
        final isNameMatch =
            item.name.toLowerCase().contains(searchQuery.toLowerCase());
        final isModelMatch =
            item.model.toLowerCase().contains(searchQuery.toLowerCase());
        final isStatusMatch =
            item.status.toLowerCase().contains(searchQuery.toLowerCase());
        return isNameMatch || isModelMatch || isStatusMatch;
      }).toList();

      if (showFavoritesOnly) {
        filteredList = filteredList.where((item) => item.isFavorite).toList();
      }

      if (selectedStatuses.isNotEmpty) {
        filteredList = filteredList
            .where((item) => selectedStatuses.contains(item.status))
            .toList();
      }

      if (selectedModels.isNotEmpty) {
        filteredList = filteredList
            .where((item) => selectedModels.contains(item.model))
            .toList();
      }

      sortItems();
    });
  }

  void sortItems() {
    setState(() {
      filteredList.sort((a, b) {
        if (isAscending) {
          return a.name.compareTo(b.name);
        } else {
          return b.name.compareTo(a.name);
        }
      });
    });
  }

  void openFilterDialog() async {
    final selectedFilters = await showDialog<Map<String, List<String>>>(
      context: context,
      builder: (BuildContext context) {
        List<String> availableStatuses =
            itemList.map((item) => item.status).toSet().toList();
        List<String> availableModels =
            itemList.map((item) => item.model).toSet().toList();
        availableStatuses.sort();
        availableModels.sort();
        Map<String, List<String>> selectedFilters = {
          'statuses': selectedStatuses,
          'models': selectedModels,
        };

        List<String> selectedStatusesTemp = List.from(selectedStatuses);
        List<String> selectedModelsTemp = List.from(selectedModels);

        return AlertDialog(
          title: Text('Filter Options'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('Favorites Only'),
                  value: showFavoritesOnly,
                  onChanged: (value) {
                    setState(() {
                      showFavoritesOnly = value!;
                      filterItems();
                    });
                  },
                ),
                ListTile(
                  title: Text('Statuses'),
                  trailing: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        selectedStatusesTemp.clear();
                      });
                    },
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  children: availableStatuses.map((status) {
                    return FilterChip(
                      label: Text(status),
                      selected: selectedStatusesTemp.contains(status),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedStatusesTemp.add(status);
                          } else {
                            selectedStatusesTemp.remove(status);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                ListTile(
                  title: Text('Models'),
                  trailing: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        selectedModelsTemp.clear();
                      });
                    },
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  children: availableModels.map((model) {
                    return FilterChip(
                      label: Text(model),
                      selected: selectedModelsTemp.contains(model),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedModelsTemp.add(model);
                          } else {
                            selectedModelsTemp.remove(model);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedStatusesTemp.clear();
                        selectedModelsTemp.clear();
                      });
                    },
                    child: Text('Clear All'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedStatuses = selectedStatusesTemp;
                  selectedModels = selectedModelsTemp;
                  filterItems();
                });
                Navigator.of(context).pop(selectedFilters);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    if (selectedFilters != null) {
      setState(() {
        selectedStatuses = selectedFilters['statuses'] ?? [];
        selectedModels = selectedFilters['models'] ?? [];
        filterItems();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
        actions: [
          IconButton(
            icon: Icon(
              showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                showFavoritesOnly = !showFavoritesOnly;
                filterItems();
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: openFilterDialog,
          ),
          IconButton(
            icon: Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
                sortItems();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchItems,
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredList[index].name),
                  subtitle: Text(
                      'Model: ${filteredList[index].model}, Status: ${filteredList[index].status}'),
                  trailing: IconButton(
                    icon: Icon(
                      filteredList[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      toggleFavorite(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
