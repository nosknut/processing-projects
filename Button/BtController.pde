import processing.serial.*;
Serial myPort; 
Buttons[] buttons;

void setup(){
  //connect();
  surface.setResizable(true);
  
  setupButtons();
}

void draw(){
  clear();
  transmit();
  updateButtons();
}

void setupButtons(){
  int numButtons = 8;
  int numHorizontals = 2;
  int wButton = 90;
  int hButton = 35;
  Vector2 gridPos = new Vector2(0, 0);
  Vector2 buttonSpacing = new Vector2(hButton, hButton);
  buttons = new Buttons[numButtons];
  
  int temp_horizontal = 0;
  int temp_vertical = 0;
  for(int i = 0; i < buttons.length; i++){
    buttons[i] = new Buttons(new Button(String.valueOf(i + 1), (gridPos.x + ((wButton + buttonSpacing.x) * temp_horizontal)), (gridPos.y + ((hButton + buttonSpacing.y) * temp_vertical)), wButton, hButton), i);
    buttons[i].button.allowDrag = true;
    if((temp_horizontal) < (numHorizontals - 1)) temp_horizontal ++;
    else
    {
      temp_vertical ++;
      temp_horizontal = 0;
    }
  }
}

void updateButtons(){
  for(Buttons button : buttons){
    button.button.update();
    //println("Updated: " + button.index);
  }
}

void transmit(){
  for(Buttons button : buttons){
    if(button.button.pressed() || button.button.released()) send(String.valueOf(button.index));
  }
}

void connect(){
  try
  {
    //if(Serial.list()[0] == null) throw new java.lang.ArrayIndexOutOfBoundsException();
    for(String port : Serial.list()) println(port);
    myPort = new Serial(this, Serial.list()[0], 9600);
    //printArray(Serial.list());
  }
  catch(java.lang.ArrayIndexOutOfBoundsException  e)
  {
    println("Searching for devices");
    printArray(Serial.list());
    connect();
  }
  catch(Exception e)
  {
    char[] error = e.getMessage().toCharArray();
    
    if(error[error.length-1] == 'y') println("Connected");
    else if(error[error.length-1] == 'd'){
      println("Unplugged");
    printArray(Serial.list());
    }
  }
}

void send(String _text){
  print("vuywbeijciu");
  try
  {
    println("Sending: " + _text);
    myPort.write(_text);
  }
  catch(Exception e)
  {
    println(e);
  }
}