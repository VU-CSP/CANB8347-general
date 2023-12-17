# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 12:53:58 2023

@author: olesk
"""

# import the pysb module and all its methods and functions
from pysb import *

# instantiate a model
Model()

# declare monomers
Monomer('R', ['phos'], {'phos': ['u', 'p']})
Monomer('S')

# input the parameter values
Parameter('k1', 1)
Parameter('k2', 1)
Parameter('R_tot', 1)

# now input the rules
Rule('R_phos', R(phos='u') + S() >> R(phos='p') + S(), k1)
Rule('R_dephos', R(phos='p') >> R(phos='u'), k2)


# observables
Observable('obsR', R(phos='u'))
Observable('obsRp', R(phos='p'))
Observable('obsS', S())

# initial conditions
Parameter('R_0', 1)
Initial(R(phos='u'), R_0)
Parameter('S_0', 0.1)
Initial(S(), S_0)
