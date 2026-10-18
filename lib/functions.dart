 List<Boxes> boxList = List.generate(9, (i) => Boxes(false, i));

class Boxes {
  bool state;
  int index;
  bool? value; // true ise x: false ise o
  // int index;

  Boxes(this.state, this.index);
}
