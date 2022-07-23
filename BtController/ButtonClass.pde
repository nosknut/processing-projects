class Vector2{
  public int x;
  public int y;
  Vector2(int _x, int _y){
    x = _x;
    y = _y;
  }
}


class Buttons{
  Buttons(Button _button, int _index){
    button = _button;
    index = _index;
  }
  Button button;
  int index;
}


public class Button{
  int hoverAnimation = 5;
  int[] defBtnColor = {100, 100, 100};
  int[] btnColor = defBtnColor;
  int[] btnHoverColor = {150, 150, 150};
  int[] btnDownColor = {125, 125, 125}; // = {200, 200, 200};
  int[] btnShadowColor = {125, 125, 125};
  int origX;
  int origY;
  int origW;
  int origH;
  int x;
  int y;
  int w;
  int h;
  String btnText = "";
  int[] defTxtColor = {255, 255, 255};
  int[] txtColor = defTxtColor;
  int[] txtHoverColor = {255, 255, 255};
  int[] txtDownColor = {255, 255, 255};
  float txtSize = 0.5;
  int rad = 10;
  boolean canBePressed = true;
  boolean prevDown = false;
  boolean prevHover = false;
  int prevMousePosX = mouseX;
  int prevMousePosY = mouseY;
  int marginL = 10;
  int marginR = 10;
  int marginT = 10;
  int marginB = 10;
  public boolean allowDrag = false;
  
  Button(String _txt, int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    btnText = _txt;
    txtSize = (h * txtSize);
    setOriginals();
    make();
  }
  
  public void setMargins(int _L, int _R, int _T, int _B){
    marginL = _L;
    marginR = _R;
    marginT = _T;
    marginB = _B;
  }
  
  void setOriginals(){
    origX = x;
    origY = y;
    origW = w;
    origH = h;
  }
  
  void stCol(int[] colors){
    int r = colors[0];
    int g = colors[1];
    int b = colors[2];
    fill(r, g, b);
  }
  
  boolean hover(){
    return (((mouseX > x) && (mouseX < (x + w))) && ((mouseY > y) && (mouseY < (y + h))));
  }
  
  boolean down(){
    return (hover() && mousePressed && canBePressed);
  }
  
  public boolean pressed(){
    return (down() && !prevDown);
  }
  
  public boolean released(){
    return ((!down() && prevDown));
  }
  
  public boolean clicked(){
    return released();
  }
  
  public boolean mouseEnter(){
    return (hover() && !prevHover);
  }
  
  public boolean mouseLeave(){
    return (!hover() && prevHover);
  }
  
  public void make(){
    stCol(btnShadowColor);
    rect(x, y, (origW + hoverAnimation), (origH + hoverAnimation), rad);
    stCol(btnColor);
    rect(x, y, w, h, rad);
    stCol(txtColor);
    textSize(txtSize);
    text(btnText, (x + (w/2) - (textWidth(btnText) / 2)), (y + (h / 2) + (txtSize / 2)));
  }
  
  void updateMouse(){
    prevHover = hover();
    prevDown = down();
    if(hover() && !mousePressed) canBePressed = true;
    if(!hover()) canBePressed = false;
    prevMousePosX = mouseX;
    prevMousePosY = mouseY;
  }
  
  void animate(){
    if(down()){
      w = origW + hoverAnimation;
      h = origH + hoverAnimation;
      btnColor = btnDownColor;
      txtColor = txtDownColor;
    }
    else
    {
      w = origW;
      h = origH;
      
      if(hover())
      {
        btnColor = btnHoverColor;
        txtColor = txtHoverColor;
      }
      else
      {
        btnColor = defBtnColor;
        txtColor = defTxtColor;
      }
    }
  }
  
  public void drag(){
    if(down()){
      x = (mouseX - (prevMousePosX - x));
      y = (mouseY - (prevMousePosY - y));
      prevMousePosX = mouseX;
      prevMousePosY = mouseY;
    }
  }
  
  public void update(){
    drag();
    updateMouse();
    animate();
    make();
  }
}