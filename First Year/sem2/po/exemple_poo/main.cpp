/*#include <iostream>

using namespace std;

int func (int a){
    cout << 'A';
}
long func (long a){
    cout <<'B';
}
f(string x){
return x;
}

int main()
{
    int a=9;
    func(a);
    float b=3;
    func(3.3);
    long x=10;
    func(x);

    int a=10;
    int *p;
    p=&a;
    *p=3;
    (*p)++;
    cout<<a<<"\n";
    cout<<*p<<"\n";
    delete p;

    int &r=a;
    int b=-3;
    r=b;
    r++;
    cout<<a<<"\n"<<b<<"\n"<<r<<"\n";
    cout<<f("dffs");
    double x = 100.1, y;
	int *p;
	/* The next statement causes p (which is an    integer pointer) to point to a double.
	p = (int*)&(x);
	printf("%d\n",*p);
	/* The next statement does not operate as    expected.
	y = *p;
	printf("%f", y); /* won't output 100.1

//	------------------------------------------------------------------------

const int i = 100;  // Typical constant
const int j = i + 10; // Value from const expr
long address = (long)&j; // Forces storage
char buf[j + 10]; // Still a const expression

  cout << "type a character & CR:";
  const char c = cin.get(); // Can't change //valoarea nu e cunoscuta la compile time si necesita storage
  const char c2 = c + 'a';
  cout << c2;
    return 0;
}
*//*
#include <iostream>
#include <vector>

template <typename T>
std::enable_if<!std::is_convertible<T, std::string>, std::ostream&>
operator<<(std::ostream& os, const T& obj) {
    os << "[";
    int nr = 0;
    for(auto iter = obj.begin(); iter != obj.end(); ++iter) {
        os << *iter;
        ++nr;
        if(iter == obj.end())
            break;
        os << ", ";
        if(nr >= 5) {
            os << "...";
            break;
        }
    }

    os << "]";
    return os;
}

int main() {
    auto vec = std::vector<std::vector<int>>{{1, 2, 3, 4, 5, 6, 7}, {3, 4, 5, 6, 7, 8}};
    std::cout << vec << "\n";
}
accumulate*/



/*
class A {
    int x;
public:
    A(int x = 7){this->x = x; cout<<"Const "<<x<<endl;}
    void set_x(int x){this->x = x;}
    int get_x(){ return x;}
    ~A(){cout<<"Dest "<<x<<endl;}
};

void afisare(A ob) {
    ob.set_x(10);
    cout<<ob.get_x()<<endl;  }

int main ( ) {
    A o1;
    cout<<o1.get_x()<<endl;
    afisare(o1);
    return 0;
}*/

/*

class cls {
    private: int x;
    public:
    cls(int x=0) { cout << "Inside constructor "<<x << endl; }
    cls(const cls& o){
        cout << "Inside copy constructor "<< endl;
        x=o.x;
    }
    void set_x(int y){x=y;}
    int get_x(){return x;}
    ~cls() { cout << "Inside destructor "<<x << endl; } };

cls f(){
    cls a(20);
    a.set_x(4);
    return a;
}

int main() {
    cls s(10);
    cout<<s.get_x()<<"\n";
    cout<<"KLJLJLK\n";
    cls c=f();
    s.set_x(2222);
    cout<<s.get_x()<<"\n";
}
*/

/*
#include <iostream>
using namespace std;
class A {
public:
    A () {cout << "A";}
    ~A () {cout << "~A";}
};
class B: virtual public A {
public:
    B () {cout << "B";}
    ~B () {cout << "~B";}
};
class C: virtual public A, public B {
public:
    C () {cout << "C";}
    ~C () {cout << "~C";}
};
int main () {
    A *pa = new C(); delete pa;
    return 0;
}*/
#include <iostream>
using namespace std;

#include <iostream>
#include <typeinfo>
using namespace std;


class Baza {public: virtual void f () { } };// tip polimorfic
class Derivata1: public Baza { };
class Derivata2: public Baza { };
int main() {     Baza *p, b;    Derivata1 d1;    Derivata2 d2;
    p = &b;
    cout << "p is pointing to an object of type "<< typeid(*p).name() << endl;
    p = &d1;
    cout << "p is pointing to an object of type " << typeid(p).name() << endl;
    p = &d2;
    cout << "p is pointing to an object of type " << typeid(*p).name() << endl;
    return 0;
}
