#ifndef OBJECTO_H_INCLUDED
#define OBJECTO_H_INCLUDED



#define ZMAX -20000.0
//#define MAXLUSES -100000.0



class Objecto{
public:
   float x,y,z,rad,cor;

    Objecto();
    ~Objecto();
    void init(float _x, float _y, float _z, float _r, float _c);
    void update(float speed);
    void draw();

};





#endif // OBJECTO_H_INCLUDED
