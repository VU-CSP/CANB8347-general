#!/usr/bin/env python
# coding: utf-8

# In[1]:


from pysb import *
from pysb.integrate import Solver


# In[2]:


Model()
Monomer('A')
Parameter('k', 3.0)
Rule('synthesize_A', None >> A(), k)
t = [0, 10, 20, 30, 40, 50, 60]
solver = Solver(model, t)
solver.run()
print(solver.y[:, 0])


# In[3]:


from __future__ import print_function
from pysb.simulator import ScipyOdeSimulator
from tutorial_a import model

t = [0, 10, 20, 30, 40, 50, 60]
simulator = ScipyOdeSimulator(model, tspan=t)
simresult = simulator.run()
print(simresult.species)


# In[4]:


import mymodel as m


# In[5]:


from pysb.simulator import ScipyOdeSimulator
import pylab as pl


# In[6]:


t = pl.linspace(0, 20000)


# In[7]:


m.model.observables


# In[8]:


simres = ScipyOdeSimulator(m.model, tspan=t).run()
yout = simres.all


# In[9]:


pl.ion()
pl.figure()
pl.plot(t, yout['obsBid'], label="Bid")
pl.plot(t, yout['obstBid'], label="tBid")
pl.plot(t, yout['obsC8'], label="C8")
pl.legend()
pl.xlabel("Time (s)")
pl.ylabel("Molecules/cell")
pl.show()


# In[ ]:




