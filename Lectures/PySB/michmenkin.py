# -*- coding: utf-8 -*-
"""
Created on Wed Mar 22 14:08:18 2023

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
Parameter('Km1', 0.01)
Parameter('Km2', 0.01)
Parameter('R_tot', 1)

# observables
Observable('obsR', R(phos='u'))
Observable('obsRp', R(phos='p'))
Observable('obsS', S())

# expressions
Expression('Rphos', (k1*obsS*(R_tot-obsRp))/(Km1+(R_tot-obsRp)))
Expression('Rdephos', (k2*obsRp)/(Km2+obsRp))

# now input the rules
Rule('R_phos', R(phos='u') + S() >> R(phos='p') + S(), Rphos)
Rule('R_dephos', R(phos='p') >> R(phos='u'), Rdephos)


# initial conditions
Parameter('R_0', 1)
Initial(R(phos='u'), R_0)
Parameter('S_0', 0.1)
Initial(S(), S_0)