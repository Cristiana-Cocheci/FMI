import numpy as np
import matplotlib.pyplot as plt

U1 = np.random.rand(1000)
U2 = np.random.rand(1000)

Z = np.sqrt( (-2)* np.log(U1)) * np.cos(2* np.pi * U2)
plt.hist(Z)

# distributie standard
#1 media
media= np.mean(Z)
print(media)
#2 deviatia standard
deviatia = np.sqrt(np.sum((Z-[media]*Z.size)**2) / Z.size)
print(deviatia)

plt.show()













