/*********
 The lirary I used was for requesting http. It's basically the equivilent of GET requests for web. Heres the github Link: https://github.com/runemadsen/HTTP-Requests-for-Processing
 ***/
import http.requests.*;


Button Album1 = new Button(100, 100, 200, 200, #EAEAEA, #FFFFFF, #000000);
Button Album2 = new Button(400, 220, 200, 200, #EAEAEA, #FFFFFF, #000000);
Button Album3 = new Button(700, 100, 200, 200, #EAEAEA, #FFFFFF, #000000);

TextBox Searchbar = new TextBox(250, 30, 500, 30, #000000, #FFFFFF, 20);

String data;
String RawInput = "";
String Raw_Enter = "";

public String[] AlbumName = new String[50];
public String[] ArtistName = new String[50];
public String[] Imagelink = new String[1000];
public String[] URL = new String[1000];

boolean searched = false;

PImage Album1cover;
PImage Album2cover;
PImage Album3cover;




void setup() {
  size(1000, 500);

  
}

void draw() {
  background(125);

  frameRate(10);
  if (searched == false) {
    Searchbar.display();
    textSize(30);
    text("Search By Album Name, Then press ENTER", 200, 100);
    textSize(15);
    text("Your spaces will automatically be replaced with \"+.\" Don't worry, Your search will still include the spaces.", 130, 130);
    
  }

  if (searched == true) {
    Searchbar.display();

    Album1cover = loadImage(Imagelink[0]);
    Album2cover = loadImage(Imagelink[1]);
    Album3cover = loadImage(Imagelink[2]);

    image(Album1cover, 100, 100, 200, 200);
    image(Album2cover, 400, 220, 200, 200);
    image(Album3cover, 700, 100, 200, 200);


    Album1.display();
    Album2.display();
    Album3.display();

    textSize(20);
    text("click on an album to listen to it on last.fm", 270, 90);

    textSize(20);
    text(AlbumName[0], 100, 320);
    text(AlbumName[1], 400, 440);
    text(AlbumName[2], 700, 320);

    textSize(20);
    text(ArtistName[0], 100, 340);
    text(ArtistName[1], 400, 460);
    text(ArtistName[2], 700, 340);



    if (Album1.clicked()) {
      link(URL[0]);
    }

    if (Album2.clicked()) {
      link(URL[1]);
    }

    if (Album3.clicked()) {
      link(URL[2]);
    }
  }
}




void keyPressed() {
  Searchbar.handleKeyPressed(key);

  if (key == ENTER && Searchbar.text!="") {
    RawInput = Searchbar.text;
    println(RawInput);
    accessAPI();
    searched = true;
    
  }

}


void accessAPI() {

  if (RawInput == "") {
    println("Please enter something into the search bar");
  } else {
    
    GetRequest getAlbum = new GetRequest("http://ws.audioscrobbler.com/2.0/?method=album.search&album=" + RawInput + "&api_key=#############");
    getAlbum.send();
    data = getAlbum.getContent();

    datagrabber(0);
    datagrabber(1);
    datagrabber(2);
    datagrabber(3);
  }
}


void datagrabber(int type) {
  int AlbumNumber = 0;
  int ArtistNumber = 0;
  int ImageNumber =  0;
  int URLNumber = 0;
  String name = "";
  boolean collect = false;

  if (type == 0) {
    for (int i = 0; i<data.length(); i++) {
      if (albumnamecheck(i) == 1) {
        collect = true;
        i=i+6;
      }
      if (albumnamecheck(i) == 2) {
        collect = false;
        AlbumName[AlbumNumber] = name;
        AlbumNumber = AlbumNumber + 1;
        name = "";
      }
      if (collect == false) {
      }
      if (collect == true) {
        name = namemaker(i, name);
      }
    }
  }

  if (type == 1) {
    for (int a = 0; a<data.length(); a++) {
      if (artistnamecheck(a) == 1) {
        collect = true;
        a=a+8;
      }
      if (artistnamecheck(a) == 2) {
        collect = false;
        ArtistName[ArtistNumber] = name;
        ArtistNumber = ArtistNumber + 1;
        name = "";
      }
      if (collect == false) {
      }
      if (collect == true) {
        name = namemaker(a, name);
      }
    }
  }

  if (type == 2) {
    for (int i = 0; i<data.length(); i++) {
      if (Imagecheck(i) == 1) {
        collect = true;
        i=i+25;
      }
      if (Imagecheck(i) == 2) {
        collect = false;
        if (name=="") {
        } else {
          Imagelink[ImageNumber] = name;
          ImageNumber = ImageNumber + 1;
          name = "";
        }
      }
      if (collect == false) {
      }
      if (collect == true) {
        name = namemaker(i, name);
      }
    }
  }

  if (type == 3) {
    for (int i = 0; i<data.length(); i++) {
      if (URLcheck(i) == 1) {
        collect = true;
        i=i+5;
      }
      if (URLcheck(i) == 2) {
        collect = false;
        URL[URLNumber] = name;
        URLNumber = URLNumber + 1;
        name = "";
      }
      if (collect == false) {
      }
      if (collect == true) {
        name = namemaker(i, name);
      }
    }
  }
}


int albumnamecheck(int i) {
  if (data.charAt(i) == 60 && data.charAt(i+1)== 110 && data.charAt(i+2) == 97 && data.charAt(i+3) == 109 && data.charAt(i+4) == 101 && data.charAt(i+5) == 62) {
    return 1;
  } 
  if (data.charAt(i) == 60 && data.charAt(i+1) == 47 && data.charAt(i+2)== 110 && data.charAt(i+3) == 97 && data.charAt(i+4) == 109 && data.charAt(i+5) == 101 && data.charAt(i+6) == 62) {
    return 2;
  } else {
    return 3;
  }
}

int artistnamecheck(int i) {
  if (data.charAt(i) == 60 && data.charAt(i+1)== 97 && data.charAt(i+2) == 114 && data.charAt(i+3) == 116 && data.charAt(i+4) == 105 && data.charAt(i+5) == 115 && data.charAt(i+6) == 116 && data.charAt(i+7) == 62) {
    return 1;
  } 
  if (data.charAt(i) == 60 && data.charAt(i+1) == 47 && data.charAt(i+2)== 97 && data.charAt(i+3) == 114 && data.charAt(i+4) == 116 && data.charAt(i+5) == 105 && data.charAt(i+6) == 115 && data.charAt(i+7) == 116 && data.charAt(i+8) == 62) {
    return 2;
  } else {
    return 3;
  }
}

int Imagecheck(int i) {
  if (data.charAt(i) == 60 && data.charAt(i+1)== 105 && data.charAt(i+2) == 109 && data.charAt(i+3) == 97 && data.charAt(i+4) == 103 && data.charAt(i+5) == 101 && data.charAt(i+6) == 32 && data.charAt(i+7) == 115 && data.charAt(i+8) == 105 && data.charAt(i+9) == 122 && data.charAt(i+10) == 101 && data.charAt(i+11) == 61 && data.charAt(i+12) == 34  && data.charAt(i+13) == 101 && data.charAt(i+14) == 120 && data.charAt(i+15) == 116 && data.charAt(i+16) == 114 && data.charAt(i+17) == 97 && data.charAt(i+18) == 108 && data.charAt(i+19) == 97 && data.charAt(i+20) == 114 && data.charAt(i+21) == 103 && data.charAt(i+22) == 101 && data.charAt(i+23) == 34 && data.charAt(i+24) == 62) {
    return 1;
  } 
  if (data.charAt(i) == 60 && data.charAt(i+1) == 47 && data.charAt(i+2)== 105 && data.charAt(i+3) == 109 && data.charAt(i+4) == 97 && data.charAt(i+5) == 103 && data.charAt(i+6) == 101 && data.charAt(i+7) == 62) {
    return 2;
  } else {
    return 3;
  }
}

int URLcheck(int i) {
  if (data.charAt(i) == 60 && data.charAt(i+1)== 117 && data.charAt(i+2) == 114 && data.charAt(i+3) == 108 && data.charAt(i+4) == 62) {
    return 1;
  } 
  if (data.charAt(i) == 60 && data.charAt(i+1) == 47 && data.charAt(i+2)== 117 && data.charAt(i+3) == 114 && data.charAt(i+4) == 108 && data.charAt(i+5) == 62) {
    return 2;
  } else {
    return 3;
  }
}

String namemaker(int i, String inputname) {

  inputname = inputname + data.charAt(i);
  return inputname;
}
