extension CollectionExtensions on List {
  void replace(item, int index) {
    if (index < this.length) {
      this.insert(index, item);
      this.removeAt(this.indexOf(item) + 1);
    } else {
      throw ('Index Out Of Bounds');
    }
  }
}
