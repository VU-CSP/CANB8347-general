Model Summary
======  
### Model originally described in:  
Bravo R, Axelrod DE. A calibrated agent-based computer model of stochastic cell dynamics in normal human colon crypts useful for in silico experiments. Theor Biol Med Model. 2013; 10 66. doi:10.1186/1742-4682-10-66. PubMed PMID: 24245614. PMCID: PMC3879123.  

* Agent-based, on-lattice cellular automata model

* Cell properties (probability of cell proliferation, probability of cell death, cell movement, and cell type) are determined by a cell’s position in two gradients along the crypt axis, a `divide` gradient and a `die` gradient. The `divide` gradient determines the probability that a cell will divide; the `divide` gradient increases from top to bottom. The `die` gradient indicates the probability that a cell will die; the `die` gradient decreases from top to bottom.  

* **Cell proliferation**: when a cell divides, one progeny cell is placed in the same position as the parent cell and the other progeny cell is placed in a position to the right and lower. Placement of one new progeny cell lower than the parent allows the crypt to increase in depth. In order to make space for the this progeny cell, the adjacent cell is pushed to the right and lower. This process is iterated. Lateral placement of one progeny cell to the right or to the left, is necessary, since if successive progeny randomly choose between left and right, then a stable crypt does not result, as can be seen in simulations by toggling off `Polar Division`. Right, rather than left, has been chosen arbitrarily. Such placement of one progeny cell laterally has been a feature of other models. If a new cell reaches the right edge of the roll-out image of the crypt it will reappear on the left.

* **Cell movement**: when a cell dies, cells below are pulled up into the empty space. This results in cells moving up in a vertical column. Cell movement is not the result of a cell being pushed up after cell division. This is consistent with the observations that cell movement continues in the absence of cell division.

* **Cell type**: a cell’s `type` is determined by its position in the divide gradient. A progeny cell that has moved away from the position of its parent will experience a different gradient value than its parent, and as a consequence may have a different phenotype than its parent. For instance, the progeny of a differentiating cell may move down into the region of a proliferating cell and become a proliferating cell. The progeny of a proliferating cell may move down into a niche region of quiescent stem cells. In the niche it responds to a quiescent gradient, not the divide gradient. A quiescent stem cell may, if cells above it are removed, move into the region of proliferating cells and become an active stem cell.

