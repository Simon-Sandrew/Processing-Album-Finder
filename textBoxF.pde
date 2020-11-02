class TextBox {
  String text;
  int x, y, w, h;
  color bgColor, txtColor;
  int tTextSize;
  boolean isActive;    //set this from controller file ie a RETURN sets to false
  //eventualy need a type variable to specify whether this box is for numerical or alpha entry

  TextBox(int x, int y, int w, int h, color bgColor, color txtColor, int tTextSize) {
    text="";
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.bgColor = bgColor;
    this.txtColor = txtColor;
    this.tTextSize = tTextSize;
    isActive = true; //but eventually we might want this false by default until we are in state = textEntryMode
  }


  void display() {
    //style will depend on isActive
    fill(bgColor);
    strokeWeight(2);
    rect(x, y, w, h);

    fill(txtColor);  //all hard coded for now until we finish the constructor
    textSize(tTextSize);
    text(text, x + 6, y + h - h/3);
  }

  void handleKeyPressed(int tKeyCode) { //not sure about these input types
    //returns will never make it here. They will be handled in controller file
    
    if(tKeyCode == SHIFT){
    }

    if (tKeyCode == BACKSPACE) {  //apparently BACKSPACE is an int constant already
      if (text.length() > 0) {
        text = text.substring(0, text.length()-1);
      }
    }

    //for numerical entry. But if this were an alpha text box we want to accept different keys a-Z
    else if (tKeyCode == 46 || (tKeyCode >= 48 && tKeyCode <= 57)) {
      text += char(tKeyCode);
    } 
    else if(tKeyCode > 64 && tKeyCode < 91 || tKeyCode > 96 && tKeyCode < 123){
      text += char(tKeyCode);
  }
    if(tKeyCode == ENTER){
      
    }
    else if(tKeyCode == 32){
      text += char(43);
    }
    
  }


  void resetText() {
    text = ""; //we might need this
  }
}
