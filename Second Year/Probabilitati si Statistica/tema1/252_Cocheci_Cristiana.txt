import numpy as np
import matplotlib.pyplot as plt

# Choose number of chords to draw in the simulation:
num_chords = 10000


def draw_circle_and_triangle(ax):
    circle = plt.Circle((0, 0), 1, color='w', linewidth=2, fill=False)
    ax.add_patch(circle)  # Draw circle
    ax.plot([np.cos(np.pi / 2), np.cos(7 * np.pi / 6)],
            [np.sin(np.pi / 2), np.sin(7 * np.pi / 6)], linewidth=2, color='g')
    ax.plot([np.cos(np.pi / 2), np.cos(- np.pi / 6)],
            [np.sin(np.pi / 2), np.sin(- np.pi / 6)], linewidth=2, color='g')
    ax.plot([np.cos(- np.pi / 6), np.cos(7 * np.pi / 6)],
            [np.sin(- np.pi / 6), np.sin(7 * np.pi / 6)], linewidth=2, color='g')
    plt.show()


def bertrand_simulation(method_number):
    # Simulation initialisation parameters
    count = 0

    # Figure initialisation
    plt.style.use('dark_background')  # use dark background
    ax = plt.gca()
    ax.cla()  # clear things for fresh plot
    ax.set_aspect('equal', 'box')
    ax.set_xlim((-1, 1))  # Set x axis limits
    ax.set_ylim((-1, 1))  # Set y axis limits

    # Repeat the following simulation num_chords times:
    for k in  range(0,num_chords):
        # Step 1: Construct chord according to chosen method
        x, y = bertrand_methods[method_number]()

        # Step 2: Compute length of chord and compare it with triangle side sqrt(3)
        length = np.sqrt((x[0]-x[1])*(x[0]-x[1])+(y[0]-y[1])*(y[0]-y[1]))
        count += (length>np.sqrt(3))
        print("Probability = {:.4f}".format(count / k))  # Display probability after each simulation
        if k <= 1000:  # only plot the first 1000 chords
            if length > np.sqrt(3):
                plt.plot(x, y, color='y', alpha=0.1)
            else:
                plt.plot(x, y, color='m', alpha=0.1)

    draw_circle_and_triangle(plt.gca())
    plt.show()
        
    
def bertrand1():
    """Generate random chords and midpoints using "Method 1".
    
    Pairs of (uniformly-distributed) random points on the unit circle are
    selected and joined as chords.

    Probabilitate:1/3
    """
    theta1=np.random.random()*2*np.pi
    theta2=np.random.random()*2*np.pi
    x=np.cos([theta1,theta2])*1 #un punct
    y=np.sin([theta1,theta2])*1 #al doilea punct random pe cerc
    return x,y
    
def in_circle(x,y):
    centrux=0
    centruy=0
    d=np.sqrt((x-centrux)**2+(y-centruy)**2)
    if(d<1):
        return 1
    return 0

def rand_negativ():
    if(np.random.random()<0.5):
        return 1
    return -1

def bertrand2():
    """The "random midpoint" method: Choose a point anywhere within the circle
      and construct a chord with the chosen point as its midpoint.
      Probabilitate 1/4
    """
    #  1 Alegem un punct in cerc cu cx si cy aleator
    cx=-1
    cy=-1
    while(in_circle(cx,cy)==0):
          cx=np.random.random() * rand_negativ()
          cy=np.random.random() * rand_negativ()
    #distanta_centru_punct=np.sqrt(cx**2+cy**2)
    panta_centru_punct=cy/cx
    
    x1=0 
    y1=0
    x2=0
    y2=0
    #calculam panta pentru coarda
    m= -1/panta_centru_punct
    #y=mx+c
    c=cy-m*cx
    #calculam coeficientii ecuatiei (cand dreapta intersecteaza cercul)
    #x^2+ m^2*x^2 +c^2-1=0
    A=m**2+1
    B=2*m*c
    C=c**2-1
    #delta
    delta= B**2-4*A*C
    if(delta>=0): #o sa fie mereu, dar na
        x1= (-B+np.sqrt(delta))/(2*A)
        x2=  (-B-np.sqrt(delta))/(2*A)
        y1=m*x1+c
        y2=m*x2+c
   
    #print(f"midpoint: {cx}, {cy}")
    #plt.plot(cx,cy,'ro');
    #plt.plot(x1,y1,'yo');
    #plt.plot(x2,y2,'yo');
    #print(f"Punctul 1 {x1}, {y1}. Punctul 2 {x2}, {y2}");
    return [x1,x2], [y1,y2]

def bertrand3():
    '''The "random radial point" method: Choose a radius of the circle, 
    choose a point on the radius and construct the chord through this point and 
    perpendicular to the radius.
    Probabilitate:1/2'''
    #alegem un unghi random
    theta=np.random.random()*2*np.pi
    #alegem un punct random pe raza de unghi theta
    dist=np.random.random()
    cx=np.cos(theta)*dist;
    cy=np.sin(theta)*dist;
    #construim perpendiculara pe raza
    panta_raza=np.tan(theta)
    panta_coarda=-1/panta_raza
    #gasim intersectia dreptei cu cercul
    c=cy-panta_coarda*cx
    #calculam coeficientii ecuatiei (cand dreapta intersecteaza cercul)
    #x^2+ m^2*x^2 +c^2-1=0
    A=panta_coarda**2+1
    B=2*panta_coarda*c
    C=c**2-1
    #delta
    delta= B**2-4*A*C
    if(delta>=0): #o sa fie mereu, dar na
        x1= (-B+np.sqrt(delta))/(2*A)
        x2=  (-B-np.sqrt(delta))/(2*A)
        y1=panta_coarda*x1+c
        y2=panta_coarda*x2+c
   
    #print(f"midpoint: {cx}, {cy}")
    #plt.plot(cx,cy,'ro');
    #print(f"Punctul 1 {x1}, {y1}. Punctul 2 {x2}, {y2}");
    return [x1,x2], [y1,y2]


#1/3 #1/4 #1/2
bertrand_methods = {1: bertrand1, 2: bertrand2, 3:bertrand3}

method_choice = input('Choose method to simulate: ')
bertrand_simulation(int(method_choice))

