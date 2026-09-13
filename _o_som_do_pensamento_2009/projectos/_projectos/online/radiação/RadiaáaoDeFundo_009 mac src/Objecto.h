#ifndef OBJECTO_H_INCLUDED
#define OBJECTO_H_INCLUDED



#define ZMAX -50000.0
//#define MAXLUSES -100000.0



class Objecto{
public:
   long double x,y,z,cor,red,green,blue;//rad;

    Objecto();
    ~Objecto();
    void init(long double _x, long double _y, long double _z, long double _c,long double _red, long double _green, long double _blue);
    void update(long double speed);
    void draw();


// the joystick data to work in the app
//    void joystick(unsigned int buttonMask, int x, int y, int z);
//
//
//		bool *joybuttons;					//botões
//		int  joyx,joyy,joyz;				//eixo(s)
//		int joynumbuttons,joynumaxes,joypresent; //características



};





#endif // OBJECTO_H_INCLUDED
