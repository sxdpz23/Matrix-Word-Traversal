import 'package:flutter/cupertino.dart';
import 'package:matrix_word_traversal_test/model.dart';

/// Main Logic
/// For Searching a text from a 2D grid of alphabets
/// In left-to-right, top-to-bottom and topLeft-to-bottomRight direction
class SearchFor {

  /// 2D grid from which the alphabet pattern to be searched
  final List<List<String>> inGrid;

  /// pattern to be searched
  final String text;

  SearchFor({required this.inGrid, this.text = ''}) ;

  // Initializing the lists for individual points to keep track
  List<PointerInfo> _eastFinds = [];
  List<PointerInfo> _southFinds = [];
  List<PointerInfo> _southEastFinds = [];

  /// checking in EAST direction for any possible matches
  bool _eastDir(int r , int c) {
    int topLimit = inGrid[0].length;
    int count=1;

    if(c==topLimit-1 && text.length==1)
      return true;

    if(c==topLimit-1)
      return false;

    int k=c+1,w=1;
    for(; w<text.length; w++,k++) {
      if(inGrid[r][k]==text.substring(w,1+w))
        count++;
      if(k==topLimit-1)
        break;
    }
    return count==text.length;
  }

  /// checking in SOUTH direction for any possible matches
  bool _southDir(int r , int c) {
    int topLimit = inGrid.length;
    int count=1;

    if(c==topLimit-1 && text.length==1)
      return true;

    if(r==topLimit-1)
      return false;

    int t=r+1,w=1;
    for(; w<text.length; w++,t++) {
      if(inGrid[t][c]==text.substring(w,1+w))
        count++;
      if(t==topLimit-1)
        break;
    }
    return count==text.length;
  }

  /// checking in SOUTH-EAST direction for any possible matches
  bool _southEastDir(int r , int c) {
    int count=1;

    if(r==inGrid.length-1 || c==inGrid[0].length-1)
      return false;

    int t=r+1, k=c+1, w=1;
    for(; w<text.length; w++,t++, k++) {
      if(inGrid[t][k]==text.substring(w,1+w))
        count++;
      if(t==inGrid.length-1 || k==inGrid[0].length-1)
        break;
    }
    return count==text.length;
  }

  /// checking from particular point
  AllDirectionalList? searchAt(int rIndex, int cIndex) {

    // checking if the first alphabet matches
    if(inGrid[rIndex][cIndex] != text.substring(0,1)) {
      return null;
    }

    // Keeping a track of matched indices for further process
    if(_eastDir(rIndex,cIndex)) {
      _eastFinds.add(PointerInfo(m:rIndex,n:cIndex));
    }
//   print("Done EAST");

    if(_southDir(rIndex,cIndex)) {
      _southFinds.add(PointerInfo(m:rIndex,n:cIndex));
    }
//   print("Done SOUTH");

    if(_southEastDir(rIndex,cIndex)) {
      _southEastFinds.add(PointerInfo(m:rIndex,n:cIndex));
    }
//   print("Done SOUTH-EAST");

    return AllDirectionalList(eastDirectionIndices: _eastFinds,
        southDirectionIndices: _southFinds,
        southEastDirectionIndices: _southEastFinds);
  }

  /// Get all the Indices to be highlighted
  AllDirectionalList getColoredIndices() {
    List<PointerInfo> list = [], eastList = [], southList = [], southEastList = [];

    // finding other indices for east pattern matched words
    for(int i=0; i<_eastFinds.length; i++) {
      eastList.add(_eastFinds[i]);
      for(int z=1; z<text.length; z++) {
        list.add(PointerInfo(m:_eastFinds[i].m,n:_eastFinds[i].n+z));
        eastList.add(PointerInfo(m:_eastFinds[i].m,n:_eastFinds[i].n+z));
      }
    }

    // finding other indices for south pattern matched words
    for(int i=0; i<_southFinds.length; i++) {
      southList.add(_southFinds[i]);
      for(int z=1; z<text.length; z++) {
        list.add(PointerInfo(m:_southFinds[i].m+z,n:_southFinds[i].n));
        southList.add(PointerInfo(m:_southFinds[i].m+z,n:_southFinds[i].n));
      }
    }

    // finding other indices for south-east pattern matched words
    for(int i=0; i<_southEastFinds.length; i++) {
      _southEastFinds.add(southEastList[i]);
      for(int z=1; z<text.length; z++) {
        list.add(PointerInfo(m:_southFinds[i].m+z,n:_southFinds[i].n+z));
        southEastList.add(PointerInfo(m:_southFinds[i].m+z,n:_southFinds[i].n+z));
      }
    }

    return AllDirectionalList(eastDirectionIndices: eastList,
        southDirectionIndices: southList,
        southEastDirectionIndices: southEastList,
        allColoredIndicesList: list.toSet().toList(growable: false));
  }
}