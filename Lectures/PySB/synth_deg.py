# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 10:00:46 2023

@author: olesk
"""

# import the pysb module and all its methods and functions
from pysb import *

# instantiate a model
Model()

# declare monomers
Monomer('R')
Monomer('S')

# input the parameter values
Parameter('k1', 1)
Parameter('k2', 5)


# now input the rules
Rule('Rsyn', S() >> R() + S(), k1)
Rule('Rdeg', R() >> None, k2)

# initial conditions
Parameter('R_0', 0.01)
Initial(R(), R_0)
Parameter('S_0', 1)
Initial(S(), S_0)

# observables
Observable('obsR', R())
Observable('obsS', S())


