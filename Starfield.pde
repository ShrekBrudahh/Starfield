body[] biden;
int zOrgin = -2000;
float rot = 0;

public void setup(){
  size(700,700,P3D);
  biden = new body[15];
  for (int i = 0; i < biden.length; i++){
    biden[i] = new body(350,250,zOrgin,-25,0,-50,rand(10,100),rand(1,4),rand(0,360),rand(5,20)/5);
  }
  biden[0] = new moon(350,350,zOrgin);
  for (int i = 0; i < biden.length; i++){
    biden[i].setValues(350,350,zOrgin,0,rot,0,0,rand(0,360),rand(5,20)/5,true);
  }
}

public void draw(){
  background(0);
  rot += 0.1;
  for (int i = 0; i < biden.length; i++){
    biden[i].setValues(0,0,0,0,rot,0,0,0,0,true);
    biden[i].show();
    biden[i].move();
  }
}


public class body{
  protected float x,y,z,size,det;
  protected float rx,ry,rz,ang,speed;
  protected PShape sphere;
  public body(){};
  public body(float xa, float ya, float za, float rxa, float rya, float rza, float sizea, float deta,float anga, float speeda){
    x = xa;
    y = ya;
    z = za;
    rx = radians(rxa);
    ry = radians(rya);
    rz = radians(rza);
    size = sizea;
    det = deta;
    ang = anga;
    speed = speeda;
  }
  public void move(){
    x += speed * Math.cos(ang);
    y += speed * Math.sin(ang);
    z += speed;
  }
  public void show(){
    pushMatrix();
    translate(x,y,z);
    rotateX(rx);
    rotateZ(rz);
    rotateY(ry);
    stroke(255,255,255);
    sphereDetail((int)(det));
    sphere = createShape(SPHERE,size);
    shape(sphere);
    popMatrix();
  }
  public void setValues(float xa, float ya, float za, float rxa, float rya, float rza, float sizea, float anga, float speeda, boolean uc){
    x = check0(x,xa,uc);
    y = check0(y,ya,uc);
    z = check0(z,za,uc);
    rx = check0(rx,radians(rxa),uc);
    ry = check0(ry,radians(rya),uc);
    rz = check0(rz,radians(rza),uc);
    size = check0(size,sizea,uc);
    ang = check0(ang,anga,uc);
    speed = check0(speed,speeda,uc);
  }
  public float[] returnNumericalValues(){
    float[] arr = {x,y,z,rx,ry,rz,size,det,ang,speed};
    return arr;
  }
}

public class moon extends body{
  private float ang;
  public moon(int xa, int ya, int za){
    x = xa;
    y = ya;
    z = za;
    rx = radians(rand(0,360));
    ry = radians(rand(0,360));
    rz = radians(rand(0,360));
    size = 200;
    det = 50;
    ang = 0;
  }
  public void move(){
    ang += radians(rand(-45,45));
    x += speed * Math.cos(ang);
    y += speed * Math.sin(ang);
    z += speed;
  }
  public void show(){
    pushMatrix();
    translate(x,y,z);
    rotateX(rx);
    rotateZ(rz);
    rotateY(ry);
    stroke(255,255,0);
    fill(0,0,0);
    sphereDetail((int)(det));
    sphere = createShape(BOX,size);
    shape(sphere);
    popMatrix();
  }
}

public void mousePressed(){
  for (int i = 0; i < biden.length; i++){
    biden[i].setValues(width/2,height/2,zOrgin,0,rot,0,0,rand(0,360),rand(5,20)/5,true);
  }
}
public float check0(float org, float f, boolean uc){
  if (f == 0 && uc == true){
    return org;
  }
  return f;
}

public int rand(int min, int max){
  return min + (int)(Math.random()*(1+(max-min)));
}

