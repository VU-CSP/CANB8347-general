; This file name: Colon_Crypt_Model_041321.nlogo

;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, version 3 of the License.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You can receive a copy of the GNU General Public License
;    at <http://www.gnu.org/licenses/>.

; Colon_Crypt_Model_041321 from Colon_Crypt_Model_040921 by deleting all Behavior Spaces previous to “Expt Runs 042120 Chronotherapy D1, I6, L2 (20 runs)"
; to avoid NetLogo version 6.2.0 giving error messages about Behavior Space text and request to run with full or partial conversion.

; Colon_Crypt_Model_040921 from Colon_Crypt_Model_073120 by changing code "range" to "rangey" to work with NetLogo version 6.2

; Colon_Crypt_Model_073120 from Crypt-11-17 has Behavior Space for chronotherapy.

; Crypt-11-22-17GRY revised from Crypt-11-22-17G by changing in code "range" to "rangey" to work with NetLogo version 6.2

; Crypt-11-22-17G revised from Crypt-11-22-17 by adding GNU License

; Crypt-11-22-17
; Revised from 11-20-17
; By Ax 112217
; Revised Interface switch "CureSound" so ON is default, and active.
; As previously,sound when all mutants eliminated, add variable "CureSound" and switch "CureSound"
; Differnt sound
; Ax 052818, added comment only: ; in order to see chemoplot for lethality = 1, need to temporarily revise default [plot 1] to [plot 0.5] and interface x max from 3 to 2

; Crypt-11-20-17
; Revised from Crypt-11-9-17
; By Ax 112017
; Add sound when all mutants eliminated, add variable "CureSound" and switch "CureSound"

; Crypt-11-9-17.nlogo
; Revised from: WC08-07-17
; By: Ax 110917
; Added sound for ChemotherapyP2
; Moved monitor box TimeToCureToMutantThreshold, and input box "MutantThreshold"
; Removed VD's input boxes from Interface, retained in Code
;     cell loss, cellLossAve, cryptValleyAvg, compensateTimeAvg
;     chemoRound, chemct
;     Crypt Valley, Crypt Peak, Crypt Regeneration Rate, Average Crypt Reg. Rate
;     tempTotal, PropSCq, PropProlif, PropDiff, PropSCqAvg, PropPolifAvg, PropDiffAvg

; WC 08-07-17 Chemo P2, Circ, Sound.nlogo
; Revised from: WC 06-17-17 Chemo P2, Circ, Sound.nlogo
; By: Vadim Dukovny
; 1. Added timeToCure to keep track of how long it takes from introduction of chemotherapy until number of mutants is below mutantThreshold
; 2. Added mutantThreshold as an input in the interface. Determines acceptable number of mutants in colon.

;WC 06-16-17 Chemo P2, Circ, Sound.nlogo
;Revised from: WC 06-06-17
;By: Vadim Dukovny
;11. Created tools to monitor "peaks" and "valleys"--highest and lowest points of ;crypt in regeneration cycle after delivery of chemotherapy. cryptValley measures ;number of cells at valley, cryptPeak number of cells at peak. valleyTime measures ;the tick in a given round at which the crypt reaches its valley,  peakTime does the ;same for a peak. These tools were then used to compute the rate of crypt ;regeneration, which is computed as (cryptPeak - cryptValley) / (peakTime - ;valleyTime). The average rate of regeneration up until a given tick is calculated as ;well.
;12. Created tools to monitor cell loss and cell loss averages--cell loss is the amount ;of cells the crypt loses after receiving a delivery of chemotherapy.
;13. Created tool to monitor round of chemotherapy and tick of each round.
;14. Fixed chemotherapy code so that correct number of ticks goes by (was off by 1).
;15. Created tools to monitor proportion of cells and average proportions of cell ;types.

;WC 06-07-17 Chemo P2, Circ, Sound.nlogo
;Revised from: WC 06-06-17 (Ax not have)
;By: Vadim Dukovny
;9. Condition added before MonoclonalTime code to see if CountTotal > 0. This is to ;avoid a runtime error when code asks "one-of" cells to do something when there ;are no cells present.
;10. MutateOneCell now only creates one yellow cell, as opposed to one yellow and one green.

;WC 05-26-17 Chemo P2, Circ, Sound (Ax not have)
;Revised from: WC 05-25-17 Chemo P2, Circ, Sound (Ax not have)
;By: Vadim Dukovny
;7. MonoclonalTime code restored, had been deleted in previous version.
;8. Some loops in applygradient functions removed, had been there in ;experimentation in previous version.

;WC 05-25-17 Chemo P2, Circ, Sound (Ax not have)
;Revised from: Crypt-5-16-17 Chemotherapy P2 ON:OFF & Plot, Circadian Plot & ;Sound Chemo.nlogo (Ax)
;1. Cells assigned random colors at birth, always pass them to progeny. ViewProgeny ;now only controls whether to see probability of division colors or progeny colors. ;New boolean and color variables created.
;2. Three-patch thick columns added at either side of crypt, referred to as "gradient ;frames." Gradient is now only displayed in the gradeint frames. New boolean and ;color variables created.
;3. Cells no longer calculate their own gradient values. Patches in gradient frame ;calculate gradient values, cells at that y-coordinate now read the values from the ;gradient patches.
;4. Crypt no longer redraws itself needlessly.
;5. Togglecolor, a method never called in the program, has been removed.
;6. Cell count uses loops and +1 instead of count function. This way, as count ;progresses, cells can also be assigned a cell type, for which the new variable
;celltype has been created. Celltype currently has no function in the code, but it ;should be ;very useful in case any future versions of the program which to perform ;an operation on cells of a given type.

; Crypt-5-16-17 Chemotherapy P2 ON:OFF & Plot, Circadian Plot & Sound Chemo
; from Crypt-3-13-17
; change "chemoprevention" to "chemotherapy P2"
; by changing in code and interface "ActivePreventTreat" to "ActiveChemoP2"
; will use "ptreatment" with "crptdiemax" as second chemotherapy
; with intention of simulating combination therapy by
; cytotoxic to kill actively dividing cells (chemo, lethality) and increase apoptosis of cells at top (chemoP2, Ptreatment)
; can also use "ActiveChemoP2" for chemoprevention, without "ActiveChemo"
; update Info

; Crypt-3-13-17 Circadian, Therapy Plot & Sound, Prevent Plot
; Revised from Crypt-1-27-17 Circadian Plot & Sound.nlogo
; Ax add from Crypt-2-24-16 Tumor het Plot Chemo Sound
; Ax 031317, plot and sound of Chemtherapy, plot Chemoprevent, Move plots
; Runs on NetLogo version 5.3.1

; Crypt-1-20-17 Circadian.nlogo
; Revised from Crypt-1-19-17.nlogo by DA on 1/20/17
; Recalibrate for 1 tick = 4 hr, rather than previous 4.5 hr.
; Revise formula of ExtraVariableY for circadian

; Crypt-1-19-17 Circadian.nlog
; Revised from Crypt-12-12-16 Circadian.nlogo by DA on 1/19/17
; add parenthesis around argument of cos, has degrees rather than radians
; Works to give proliferating cells period of ~5.3 ticks, as expect.

; Crypt-12-12-16 Circadian.nlog
; Revised from Crypt-11-22-16 Circadian.nlog by DA on 12/12/16
; Revise ";cell division and death occurs here" to include "set probdivide probdivide*ExtraVariableY"

; Crypt-11-22-16 Circadian.nlogo
; Revised from Crypt-11-5-14 Circadian, by DA on 11/22/16
; Change plot scales, change Interface, revise Info, change code "set Circadian false".

; Crypt-11-5-14 Circadian.nlogo
; Crypt-11-5-14 Circadian revised from Crypt-11-5-14 Tumor het-2, by Sudeepti Vedula on 11/16/16
; Changes "; cell division and death occurs here", to include probdiv times cosine function

; Crypt-11-5-14 Tumor het-2, revised from Crypt-11-5-16 Tumor het, by SV using NetLogo 5.3.1

; Crypt-11-5-14
; attempt to modify code to include 2 mutants with different MutantDivideDiff, for experiments with tumor heterogeneity
; change occurences of "mutant" to "mutantA" and "mutantB"
; James Obaniyi and David Axelrod

; Nov. 12, 2014 Seems to work.
; 1. From single Mutant, added MutantA and MutantB
; 2. MutantRows separatedly for MutantA and MutantB
; 3. MutantOneCell creates MutantA and MutantB simultaneously
; 4. Made separate input boxes for ProportionA and ProportionB, and defaults for each
; 5. Two plots ProportionA and ProportionB
; 6. MutantDivideDiff and MutantDieDiff separately for MutantA and MutantB
; 7. Applies Chemotherapy and Applies Chemoprevention seem to work as expected
; 8. UnboundedSizeTime reports as expected

; Crypt-6-25-14
; Revised from Crypt-12-9-13, by Rafael Bravo
; To simulate tumor heterogeneity by having several mutants with diffent MutantDivideDif and/or MutantDieDiff, and progeny inherit
; by adding myDivideDiff, and myDieDiff
; To report the number of each different mutant, see "Behavior Space  Mut Het 062514 count each kind mut.tiff"

; Crypt-12-9-13
; Revised from Crypt-5-29-13, by David Axelrod
; Revise script, add toggle and input boxes at Interface. "Ax" in comments. Use chemotherapy as example.
; Purpose: Chemoprevention by intermittent treatment.
; Intend for treatment (ptreatment value) to intermittently change CptDieMax between 0.2 and  > 0.52 which is the most that normal crypts will tolerate before going extinct.
; Add: preventct, activepreventtreat (toggle), pinterval, pduration, ptreatment (boxes)
;      whereever, chemoct, activechemo, interval, duration, treatment

; Rafael Bravo May 29, 2013
;Jan. 31, 2013 (Comment out duration = 8x interval)
; 05/24/13 : added ExtraVariable for use with behavior space, servers no direct purpose to procedures.
; 05/29/13 : added second ExtraVariable for use with behavior space, once again Extravariables X and Y serve no purpose to procedures.



extensions [sound] ; Ax 022316, Ax 020117

globals[ ;variables that are accessed by mutliple methods (globally) are named here
  keepgoing ;set as false when either the crypt is reduced to a single layer of cells or the crypt grows over the top of the world.
  gradientson  ;boolean used to determine whether gradients have already been turned on or not
  MonoclonalTime; used to display how many ticks it takes for monoclonal conversion to occur
  ExtinctionTime; displays the tick at which the crypt collapses
  UnboundedSizeTime; displays the tick at which the crypt produces polyps (overflow)
  CellsInLumen; displays the number of cells specifically in the lumen, above the crypt.
  FissionTime; time it takes the crypt to split into multiple crypts after random cell div. is turned on
  ;Protrusion; distance from the lumenal surface that cells protrude (usually zero)
  highest; depth of the crypt

  chemoct ; used to keep track of the chemotherapy interval.
  chemoRound ;round of chemotherapy
  preventct; Ax, keeps track of prevention treatment interval.
  cellsLastRound ;number of cells in crypt at the end of the last round of chemotherapy
  cellLoss ;number of cells lost at the beginning of the current round of chemotherapy
  cellLossAvg
  cellGain ;number of cells gained over the compensational regeneration period
  cellGainAvg
  cryptValley ;number of cells at lowest point after treatment
  cryptValleyAvg
  cryptPeak ;number of cells at the end of the crypt's compensational regeneration period
  valleyTime ;time at which valley was reached
  peakTime ;time at which peak was reached
  compensateTime ;peakTime - valleyTime
  compensateTimeAvg
  cryptRegRate ;rate at which crypt regenerates itself after each treatment round
  cryptRegRateAvg ;average rate of crypt regeneration over this treatment
  tempTotal

  timeToCure ;keeps track of how long it takes for chemotherapy to get mutants below mutantThreshold
  ;mutantThreshold ;set acceptable number of mutants in colon--when there are fewer mutants than mutantThreshold, the patient is "cured"

  colored ; binary, keeps track of whether progeny are colored or not.s
  top; size of world, altered by setup
  CellsPerRow ; number of cells per row in crypt, altered by setup
  CutOffAboveQuiescentRegion ; the cutoff between what is called a quiescent and a differentiated cell, since they are both defined as having a probability of dividing lower than DiffCellProbabilityThreshold
; is done spacially, by drawing a line "CutOffAboveQuiescentRegion" cell rows above the quiescent gradient, and all cells above this line are counted as differentiated, while cells below are counted as quiescent
; this indicator may miscount cells if the proliferating region is too small, and may need to be modified for the counts and plots below to print the desired cell groups.
ExtraVariableX; used in behavior space, because no new variables can be introduced within behavior space.
ExtraVariableY; used in behavior space


  CountSCq ; globals display respective cell types, useful for easier reporting in behavior space.
  CountProlif
  CountDiff
  CountMutantA
  CountMutantB
  CountTotal

  PropSCq ;proportions of each type of cell in the crypt
  PropProlif
  PropDiff

  PropSCqAvg
  PropProlifAvg
  PropDiffAvg


  MONOCLONALCOMPLETE; temporary variable

  ]


patches-own
[
  divgradient   ;boolean determining whether patch is in div gradient
  diegradient   ;boolean determining whether patch is in die gradient
  gradientprobdiv   ;probability of division at this point in the gradient
  gradientprobdie   ;probability of death at this point in the gradient
  gradientprobdivcolor   ;color representing probability of division at this point in the gradient
  gradientprobdiecolor   ;color representing probability of death at this point in the gradient

]

breed [cells cell]

cells-own [; variables that the cells themselves posess are named here
  celltype   ;shows cell type: quiescent, proliferating, or differentiated

  probdivide ;float from 0 to 1, a cell will divide if rand is less than this value. imposed by applygradientchancedivide and can be influenced if cell is mutated.
  probdividegoal

  probdie ;float from 0 to 1, a cell will die if rand is less than this value. imposed by applygradientchancedie and can be influenced if cell is mutated.
  probdiegoal

  probdividecolor ;cell stores color reflecting its probability of division
  progenycolor ;cell stores color reflecting its progeny

  changespeeddiv; these are used for delayed feedback, stores the feedback of the current gradient
  changespeeddie

  mutantA ; JO & AX 110514
  mutantB ; JO & AX 110514

  myDivideDiff
  myDieDiff
]

to setup ; properly sizes the world, and populates it with the specified number of cells OBS ONLY

  let qdtemp QuiesceDepth; temporary variables store QuiesceDepth and RowsAtStart, which are sliders that have top as their maximum, so that the settings of these variables are not lost when top is set to 0 by clearall
  let rastemp RowsAtStart
  let ddetemp DieDepthEnd
  ;; (for this model to work with NetLogo's new plotting features,
  ;; __clear-all-and-reset-ticks should be replaced with clear-all at
  ;; the beginning of your setup procedure and reset-ticks at the end
  ;; of the procedure.)
  __clear-all-and-reset-ticks
  set CutOffAboveQuiescentRegion 5
  set top SetTop
  set RowsAtStart rastemp
  set QuiesceDepth qdtemp
  set DieDepthEnd ddetemp
  set-default-shape cells "circle"
  set CellsPerRow SetCellsPerRow
  resize-world -8 cellsPerRow + 7 0 top + 2 ; world is sized so that it fits around the crypt with four spaces of buffer to the left and right. two spaces of buffer are added to the top of the crypt.
; y coordinates move up from 0 at bottom of the world to top+2 at the top.
  set-patch-size 400 / top ; resizes world so that it will fit in the window space alotted, (Does not work in all cases, if crypt is too wide, world will overlap buttons)
  let x 0
  let y top
  while [y > top - RowsAtStart][
    set x 0
    while [x < cellsPerRow][;this section of code populates the crypt, placing a cell at every location in the crypt from the bottom to RowsAtStart, going row by row.
    makecell(.5)(.5)(x)(y) ;makecell creates cells at target location with starting values set.
    set x x + 1]
  set y y - 1]
   set keepgoing true
   set chemoct -1
   set preventct -1; Ax
   set colored false
 ;globals are set to their starting values.


;crypt is setup

 ask patches
 [
   ifelse pycor <= top
   [
     if (pxcor <= min-pxcor + 3) [set pcolor 0 set divgradient true]   ;patches in the divide gradient frame are determined and initially set to black
     if (pxcor >= max-pxcor - 3) [set pcolor 0 set diegradient true]   ;patches in the die gradient frame are determined and initially set to black
     if (pxcor > min-pxcor + 3) and (pxcor < max-pxcor - 3) [set pcolor 132  set divgradient false  set diegradient false]   ;patches in the crypt are colored light brown, patches in the gradient frame are set to black for now
   ]
   [set pcolor 0]  ;patches in top buffer above crypt are left black

 ]

;cells receive initial values and random colors

 ask cells
 [
   set probdivide probdividegoal
   set probdie probdiegoal
   set progenycolor random-float 140 ;each cell's progeny color is initially set to a random color
 ]



 set MONOCLONALCOMPLETE false

end

to go ; iterates the simulation OBS ONLY


; sound:play-note "APPLAUSE" 65 127 2, plays sound after mutant cells eliminated, with or without chemoprevention, Ax 112217

if CureSound = true and count cells with [mutantA = true] + count cells with [mutantB = true] > 0
     [set CureSound false]
if CureSound = false and count cells with [mutantA = true] + count cells with [mutantB = true] = 0
    [ set CureSound true sound:play-note "APPLAUSE" 65 127 2]


; two reasons why the simulation would need to stop, either the crypt overflows or the crypt dies, the rest of the simulation assumes neither of these occured.

  if count cells = 0 and keepgoing = true[set keepgoing false set ExtinctionTime ticks print (word "the crypt died at tick " ExtinctionTime)]; if there is less than one full row of cells, cell death and division stops, and the crypt is considdered dead.
  if count cells with [ycor = top + 2]> 0 and keepgoing = true [ set keepgoing false set UnboundedSizeTime ticks print (word "the crypt overflowed at tick" UnboundedSizeTime) ]
  if keepgoing = true[  ; keepgoing is set to false if the crypt dies or overflows, prevents simulation from continuing at that point.

; sets up highest (approx number of rows of cells)

  set highest round(count cells / cellsperrow); determines the approximate top of the crypt, estimated by the average height of the cell columns.


; sets up and applies gradient functions

  ; exponential gradient functions take arguments start height, end height, start value, end value
  ; and power. this scales the function y = x^(power) from zero to 1 so that the
  ; rangey is applied from start height to end height and so that the y value is proprtionally
  ; gradient values scaled to range between startvalue and endvalue.

  applygradientprobdivide(top)(top - highest)(cptdivmin)(cptdivmax)(cptdivpwr)(DivideFbk) ;feedbackdiv set to quiescefeed so that both could be modified in parallel in behavior space.
  applygradientprobdie(top - DieDepthEnd)(top)(cptdiemin)(cptdiemax)(cptdiepwr)(DieFbk) ;applies gradient that sets probdie of cells at every iteration
  applygradientprobdivide(0)(top - quiescedepth)(0)(0)(0)(QuiescentFbk) ;quiescent gradient applies to cell division.
  ask cells[set probdivide probdivide + (probdividegoal - probdivide) * changespeeddiv
      set probdie probdie + (probdiegoal - probdie) * changespeeddie ; gradients are applied to cells, cells are only affected by the last probdivide and probdie gradients, in order as in the code


; cell division and death occurs here, revised by DA 12/12/16 to include "set probdivide probdivide * ExtraVariableY"

if Circadian = true[
set ExtraVariableY 1.00591 + 0.143376 * cos (60 * ticks - 175.574) ; DA revised 012017
]
if Circadian = false[
  set ExtraVariableY 1
]
    let rand random-float 1
; generates a random floating point number from 0 to 1 for every comparison called rand
set probdivide probdivide * ExtraVariableY
    if rand < probdivide [
      hatch-cells 1
       makespace(self) ; if rand is less than the probdivide, the cell reproduces
      ]]
ask cells [    ; after cell proliferation is taken care of, all cells have a probability of dying.
    let rand random-float 1
    if rand < probdie [    ; if rand is less than probdie, the cell dies
      die
      ]]


; sets up and applies chemotherapy

if activechemo = true and chemoct = -1 [
 set chemoct 1
 set chemoRound 1
 set cryptRegRateAvg 0
 set cellLossAvg 0
 set cryptValleyAvg 0
 set compensateTimeAvg 0
 set timeToCure 0
 ]
if activechemo = true and chemoct <= duration [sound:play-note "Clarinet" 65 30 1]  ; AX 022316 add this line for sound, works
if activechemoP2 = true and preventct <= pduration [sound:play-note "Clarinet" 75 30 1]; Ax 110917 sound for Chemotherapy P2
if activechemo = false and chemoct > -1 [set chemoct -1] ; stops chemotherapy if activechemo is set to false

if activechemo = true[  ;VD 080717
  if count cells with [mutantA = true] > mutantThreshold[set timeToCure timeToCure + 1]]

if chemoRound = 1 and chemoct = 1 [set cellsLastRound count cells]

if chemoct = 1[
  set cryptValley count cells
  set valleyTime 0
  set peakTime 0]

if chemoct >= 1 [
  set tempTotal count cells

  if chemoct <= duration[
    ask cells[
      let rand random-float 1
      if rand / lethality < probdivide[
      die]
    ]
  ]

ifelse tempTotal <= cryptValley [set cryptValley tempTotal set valleyTime chemoct set cryptPeak cryptValley]
[if tempTotal > cryptPeak [set cryptPeak tempTotal set peakTime chemoct]]

ifelse chemoct = interval[
  set chemoct 1
  set cellGain cryptPeak - cryptValley
  set cellGainAvg (cellGain * (chemoRound - 1) + cellGain) / chemoRound
  set cellLoss cellsLastRound - cryptValley
  set cellLossAvg (cellLossAvg * (chemoRound - 1) + cellLoss) / chemoRound
  set cryptValleyAvg (cryptValleyAvg * (chemoRound - 1) + cryptValley) / chemoRound
  if peakTime != valleyTime [set cryptRegRate (cryptPeak - cryptValley) / (peakTime - valleyTime)]
  set cryptRegRateAvg (cryptRegRateAvg * (chemoRound - 1) + cryptRegRate) / chemoRound
  set compensateTime peakTime - valleyTime
  set compensateTimeAvg (compensateTimeAvg * (chemoRound - 1) + compensateTime) / chemoRound
  set chemoRound chemoRound + 1
  set cellsLastRound tempTotal] ;updates chemo round
  [set chemoct chemoct + 1]
]


    ; Ax, REVISE FROM HERE. sets up and applies chemoprevention, using "sets up and applies chemotherapy" as example. 2nd try.

  if ActiveChemoP2 = true and preventct = -1 [set preventct 0 ]; Ax, initates chemoprevention
  if ActiveChemoP2 = true and preventct < pduration and ptreatment > cptdiemax [ set cptdiemax ptreatment]
  if preventct >= pduration [set cptdiemax 0.2]
  if ActiveChemoP2 = false and preventct > -1 [set preventct  -1] ; Ax, stops chemoprevention if activepreventtreat is set to false
  if preventct >= 0 [
    if preventct < pduration [
      ask cells [
        let rand random-float 1
        if rand / ptreatment < probdivide [
          die]
        ]
      ]
   ifelse preventct = pinterval[set preventct 0]
   [set preventct preventct + 1]
  ]

  ; Result. Above seems to work. CptDieMax cycles between ptreatment value and cptdiemax = 0.2 when Apply Chemoprevention is ON.
  ; Semms to have reasonable pinterval times and pduration times.
  ; Crypt stable for ptreatment = 1.5, but not 1.6 and above. Goes extinct.
  ; See white (dead) cells flush out at top, periodically.

  shiftdown; keeps cell columns without gaps by forcing cells to move up if there is a space above them.


; colors cells

ask cells with [mutantA = false and mutantB = false]
[
  ifelse probdivide <= DiffCellProbabilityThreshold [set probdividecolor probdie / CptDieMax * 5 + 94]
    [set probdividecolor probdivide / CptDivMax * 9 + 11]

  ifelse viewprogeny = true [set color progenycolor][set color probdividecolor] ;depending on choice of view, sets cell color to progeny color or to color reflecting probability of division
]

ask cells with [mutantA = true][set color 45] ; changes color of mutantA cells to yellow so that they are easily visible. Yellow color is retained even if viewprogeny is true
ask cells with [mutantB = true][set color 65] ; changes color of mutantB cells to lime so that they are easily visible. Yellow color is retained even if viewprogeny is true


; sets up FissionTime reporter

  ifelse PolarDivision[
    set FissionTime 0][
    let emptycolumn false
    let x 0
    repeat CellsPerRow [
      if count cells with [xcor = x] = 0[
        set emptycolumn true]
      set x x + 1] ; iterates through all cell columns, seeing if any of them are empty
    if emptycolumn = false [
      set FissionTime FissionTime + 1]; if no empty column exists, fission time will continue to be incremented
  ]


; misc.

 ; do-plot ; plots cell populations at the end of each iteration.
 ; if AdjustTime > ticks and cryptsizeadjust = true [
 ;   adjustcptdiemax]  ; applies cryptsizeadjust if it is being used.


;sets celltype and counts number of cells of a given type

set CountSCq 0
set CountDiff 0
set CountProlif 0
set CountMutantA 0
set CountMutantB 0
set CountTotal 0

ask cells[
  if (ycor < top - quiescedepth + CutOffAboveQuiescentRegion) and (probdivide < DiffCellProbabilityThreshold) and (MutantA = false) and (MutantB = false)[
  set celltype "SCq"
  set CountSCq CountSCq + 1]

  if (ycor >= top - quiescedepth + CutOffAboveQuiescentRegion) and (probdivide < DiffCellProbabilityThreshold) and (MutantA = false) and (MutantB = false)[
  set celltype "Diff"
  set CountDiff CountDiff + 1]

  if (probdivide >= DiffCellProbabilityThreshold) and (MutantA = false)[
  set celltype "Prolif"
  set CountProlif CountProlif + 1]

  if MutantA = true[
  set celltype "MutantA"
  set CountMutantA CountMutantA + 1]

  if MutantB = true[
  set celltype "MutantB"
  set CountMutantB CountMutantB + 1]
]

set CountTotal CountSCq + CountDiff + CountProlif + CountMutantA + CountMutantB

if CountTotal > 0[
set PropSCq CountSCq / CountTotal
set PropProlif CountProlif / CountTotal
set PropDiff CountDiff / CountTotal]

ifelse ticks <= 1 or CountTotal = 0 [set PropSCqAvg PropSCq set PropProlifAvg PropProlif set PropDiffAvg PropDiff][
  set PropSCqAvg (PropSCqAvg * (ticks - 1) + PropSCq) / ticks
  set PropProlifAvg (PropProlifAvg * (ticks - 1) + PropProlif) / ticks
  set PropDiffAvg (PropDiffAvg * (ticks - 1) + PropDiff) / ticks]

;calls plotting function

do-plot ; plots cell populations at the end of each iteration.
if AdjustTime > ticks and cryptsizeadjust = true [
   adjustcptdiemax]  ; applies cryptsizeadjust if it is being used.


;determines whether or not monoclonal conversion has been achieved and if so at what tick

if CountTotal = 0 [set ExtinctionTime ticks]

if CountTotal > 0[
  let testcolor 0
  ask one-of cells [set testcolor progenycolor]
  if MONOCLONALCOMPLETE = false[
    set MONOCLONALCOMPLETE true
    ask cells [if progenycolor != testcolor [set MONOCLONALCOMPLETE false]]

  if MONOCLONALCOMPLETE = true [set monoclonaltime ticks]
]
]

  ]
     tick; view is updated at every tick

end

to makecell[setprobdivide setprobdie x y];places a cell with specified parameters at the specified x y coordinates, called by setup, OBS ONLY

  create-cells 1 [
    setxy x y
    set probdivide setprobdivide; setprobdivide and setprobdie are specified at the method call.
    set probdie setprobdie ; if cell falls within gradient limits, these values will be overwritten by gradient
    ; set mutant false
    set mutantA false ; JO & Ax 110514
    set mutantB false ; JO & Ax 110514
    set color 9.9
    ]
end


; duplicated "mutaterows" to "mutaterowsA" and "mutaterowsB" JO & Ax 110514
to mutaterowsA;turns proportion cells between rows startH and endH mutant, startH and endH counting from bottom of crypt

  if startD > endD [let temp startD
    set startD endD
    set endD temp]
  ask cells with [top - ycor >= startD and top - ycor <= endD][
    let rand random-float 1
   ; if rand < proportion[
      if rand < proportionA[ ; JO & Ax 111214
     ; set mutant true
       set mutantA true]]
end

to mutaterowsB;turns proportion cells between rows startH and endH mutant, startH and endH counting from bottom of crypt

  if startD > endD [let temp startD
    set startD endD
    set endD temp]
  ask cells with [top - ycor >= startD and top - ycor <= endD][
    let rand random-float 1
    ;if rand < proportion[
      if rand < proportionB[
     ; set mutant true
       set mutantB true]]
end

to makespace[celltomove]; forces cells out of the way to make room for a newly generated cell
  let currx [xcor] of celltomove
  let curry [ycor] of celltomove
  let nextx 0
  ifelse polardivision [
    set nextx random 2 + 1 + currx]
  [set nextx random 3 - 1 + currx]; depending on whether or not divdirrand is on, cells will either move preferentially to the right, or move down with no right-left preference.
  let nexty curry - 1
  if nextx < 0 [
    set nextx CellsperRow + nextx]
  if nextx >= CellsperRow [
    set nextx nextx - CellsperRow]
  let nextcell one-of cells with [xcor = nextx and ycor = nexty]
  ask celltomove[
    setxy nextx nexty
    while [count turtles-at 0 1 = 0 and ycor != top][setxy xcor ycor + 1]]
  if nextcell != nobody [
    makespace(nextcell)]
end

to shiftdown ;forces all cells up in columns so there are no gaps in the crypt.
  let y top - 1
  while [y >= 0][; goes from the top of the world to the bottom.
  ask cells with [ycor = y and count cells-at 0 1 = 0][; gets all cells with an empty space above them in a particular row,
    let movedown 0
  while[count cells-at 0 (movedown + 1) = 0 and y + movedown <= top - 1][
    set movedown movedown + 1] ; finds the highest space above the cell that does not contain a cell.
    setxy xcor ycor + movedown ] ; moves the cell to this location
  set y y - 1]
end

to do-plot ; parameters used in conjunction with plots, called by Go function at the end of each iteration, does not affect simulation itself.
  set-current-plot "Total Cells"
  set-current-plot-pen "cellspen"
  plot CountTotal
   set-current-plot "Quiescent Stem Cells"
  set-current-plot-pen "CountQuiescentpen"
  plot CountSCq
  set-current-plot "Proliferating Cells"
  set-current-plot-pen "CountProliferatingPen"
  plot CountProlif
  set-current-plot "Differentiated Cells"
  set-current-plot-pen "CountDifPen"
  plot CountDiff
  ; set-current-plot "Proportion Mutant Cells"
  ; set-current-plot-pen "PropMuts"
  ; if count cells > 0 [plot count cells with [mutant = true]/ count cells] ; Proportion Mutant cells diplays number of mutant cells divided by total number of cells.
  ; JO & AX 110514
set-current-plot "Proportion MutantA Cells" ; JO & Ax 111214, and following lines. Make new plot boxes.
  set-current-plot-pen "PropMutsA"
  if count cells > 0 [plot count cells with [mutantA = true]/ count cells] ; Proportion Mutant cells diplays number of mutant cells divided by total number of cells.
set-current-plot "Proportion MutantB Cells"
  set-current-plot-pen "PropMutsB"
  if count cells > 0 [plot count cells with [mutantB = true]/ count cells] ; Proportion Mutant cells diplays number of mutant cells divided by total number of cells.
; NOTE: will need to make 2 boxes for "Proportion MutantA Cells"
set-current-plot "Chemotherapy" ; Ax 031317 from Ax 022316, to add Chemotherapy plot that indicates Lethality as function of time, with Interval, Duration, and Lethality inputs
   set-current-plot-pen "lethality"
   set-plot-pen-color 14
  if activechemo = true and chemoct > duration [plot 1] ; in order to see chemoplot for lethality = 1, temporarily need to revise default [plot 1] to [plot 0.5] and interface x max from 3 to 2
  if activechemo = true and chemoct < duration  [plot lethality]
;set-current-plot "Chemoprevention" ;Ax 031317, to add Chemoprevention plot that indicates PTreatment as function of time, with PInterval, PDuration, and Ptreatment inputs
;   set-current-plot-pen "PTreatment"
;   set-plot-pen-color 64
;  if activepreventtreat = true and preventct > duration [plot 0.2]
;  if activepreventtreat = true and preventct < duration  [plot ptreatment]
set-current-plot "Chemotherapy P2" ; Ax 050617, changed from "Chemoprevention" to "Chemotherapy 2"
   set-current-plot-pen "PTreatment"
   set-plot-pen-color 64
  if ActiveChemoP2 = true and preventct > duration [plot 0.2]
  if ActiveChemoP2 = true and preventct < duration  [plot ptreatment]

end


;The following two reporters work with the gradient functions immediately after

to-report getgradientprobdiv
  report gradientprobdiv
end

to-report getgradientprobdie
  report gradientprobdie
end

; The following code creates a gradient effect over the area, startval and endval must be between 0 and 1, startpoint and endpoint must be between the
; beginning and end of the model. note, the variable that the gradient affects cannot be stated as a parameter for the function, so the
; function had to be duplicated to affect probdivide and probdie.


to applygradientprobdivide [starty endy startval endval power feedback] ; gradient that applies to probdivide of all cells between startval and endval.
  if starty != endy [
  if power < 0[ ; the function used here is x^n, where x is from 0 to 1. the value of x ranges between 0 and 1 regardless of the value of n,
    let temp endy
    set endy starty
    set starty temp
    set temp endval
    set endval startval
    set startval temp] ; this bit of code reverses variables so that negative powers cause the graph's inflection to bow outward from 0 to 1.
  let rangey starty - endy ; graph originally goes from 0 to 1, but is scaled by rangey and set to go from starty to endy.
  let shift startval - endval ; similarly, in x^n from 0 to 1, the value of x goes from 0 to 1, but is scaled by shift and set to go from startval to endval
  let y starty
  let counter 0
  ;if gradientdivcalculated = false[
  while[counter <= abs(rangey)][
    ask patches with[(pycor = y) and (divgradient = true)][   ;patches in the divide gradient frame determine the divide gradient at this y
      ifelse shift > 0
      [set gradientprobdiv (- abs((pycor - starty) / rangey)^ abs(power)) * abs(shift) + startval]
      [set gradientprobdiv abs((pycor - starty) / rangey)^ abs(power) * abs(shift) + startval]; positive scaled graph x^n is applied here

      ifelse shift > 0
      [set gradientprobdivcolor 61 + 7 * (- abs((pycor - starty) / rangey)^ abs(power)) * abs(shift) + startval] ; to apply negative gradient, scaled graph x^n is inverted
      [set gradientprobdivcolor 61 + 7 * abs((pycor - starty) / rangey)^ abs(power) * abs(shift) + startval] ;pcolor is affected rather than probdivide and probdie.
    ]

    ask cells with[ycor = y][
      set probdividegoal [getgradientprobdiv] of patch min-pxcor y
      if mutantA = true[set probdividegoal probdividegoal + mutantAdividediff]
      if mutantB = true[set probdividegoal probdividegoal + mutantBdividediff]
      set changespeeddiv feedback
    ]

    ifelse rangey < 0[set y y + 1][set y y - 1]
    set counter counter + 1
  ]

  ifelse showgradients = true
  [ask patches with [divgradient = true][set pcolor gradientprobdivcolor]]
  [ask patches with [divgradient = true][set pcolor 0]]

]

end

to applygradientprobdie [starty endy startval endval power feedback] ; a duplicate of applygradientprobdivide, only it affects probdie.
  if starty != endy [
  if power < 0[
    let temp endy
    set endy starty
    set starty temp
    set temp endval
    set endval startval
    set startval temp]
  let rangey starty - endy
  let shift startval - endval
  let y starty
  let counter 0
  while[counter <= abs(rangey)][
    ask patches with[(pycor = y) and (diegradient = true)][   ;patches in the die gradient frame determine the die gradient at this y
      ifelse shift > 0
      [set gradientprobdie (- abs((pycor - starty) / rangey)^ abs(power)) * abs(shift) + startval]
      [set gradientprobdie abs((pycor - starty) / rangey)^ abs(power) * abs(shift) + startval]; positive scaled graph x^n is applied here

      ifelse shift > 0
      [set gradientprobdiecolor 12 + 7 * (- abs((pycor - starty) / rangey)^ abs(power)) * abs(shift) + startval] ; to apply negative gradient, scaled graph x^n is inverted
      [set gradientprobdiecolor 12 + 7 * abs((pycor - starty) / rangey)^ abs(power) * abs(shift) + startval] ;pcolor is affected rather than probdivide and probdie.
    ]

    ask cells with[ycor = y][
      set probdiegoal [getgradientprobdie] of patch max-pxcor y
      if mutantA = true[set probdiegoal probdiegoal + mutantAdiediff]
      if mutantB = true[set probdiegoal probdiegoal + mutantBdiediff]
      set changespeeddie feedback
    ]

    ifelse rangey < 0[set y y + 1][set y y - 1]
    set counter counter + 1
  ]

  ifelse showgradients = true
  [ask patches with [diegradient = true][set pcolor gradientprobdiecolor]]
  [ask patches with [diegradient = true][set pcolor 0]]

]

end


to defaults ; sets defaults for all variables modifyable in main interface, see information for justifications for values.
   set Settop 100
   set RowsAtStart 61; gets crypt into a steady state position as quickly as possible.
   set setcellsperrow 38; simulates approximate number of cells to produce proper crypt diameter if wrapped into a cylinder
   set quiescedepth 60; produces the proper number of cell rows
   set CptDivMin 0; cells will not divide towards the top of the crypt
   set CptDivMax .5; gives cells a high probability of dividing near the bottom of the crypt, so that feedback has greater effect
   set CptDivPwr 11.5; keeps cell division happening only near the bottom of the crypt.
   set CptDieMin 0; cells near the bottom of the crypt have almost zero probability of dividing, with cell removal only happening near the top
   set CptDieMax .2; this kills off cells at the proper rate to keep a steady crypt with the right proportions of cells.
   set CptDiePwr 14; keeps cell death only happening towards the extremem top of the crypt.
   set DieDepthEnd 100; die gradient speads over the entire area of the crypt.
   set DiffCellProbabilityThreshold .02; this value only changes the classification of cells in the crypt, and was adjusted to get proper cell proportions.
   ; set mutantdividediff .16; makes mutant cells divide more quickly, one of the hallmarks of mutation leading to cancer.
   ; set mutantdiediff .1; makes mutant cells more likely to die, also typically occurs with early mutant cells (less stability than normal cells.)
   ; JO & Ax 110514

   set mutantAdividediff .16; makes mutant cells divide more quickly, one of the hallmarks of mutation leading to cancer.
   set mutantAdiediff .1; makes mutant cells more likely to die, also typically occurs with early mutant cells (less stability than normal cells.)set MutateDepth 59
   set mutantBdividediff .16; makes mutant cells divide more quickly, one of the hallmarks of mutation leading to cancer.
   set mutantBdiediff .1; makes mutant cells more likely to die, also typically occurs with early mutant cells (less stability than normal cells.)
   set mutantThreshold 0 ;sets acceptable number of mutants to 0

   set showgradients false; increases running speed.
   set Lethality 2; adjusted to this value to be more effective at killing off cells, since the crypt is more robust.
   set ptreatment 0.2 ; Ax, same initial value as initial CptDieMax
   set activechemo false
   set ActiveChemoP2 false
   ; if activepreventtreat true [CptDieMax ptreatment] ; Ax, is this necessary?
   set interval 24
   set pinterval 24 ; Ax
   set duration 3
   set pduration 3 ; Ax
   set startD 55; ensures mutant cells begin in the quiescent region
   set PolarDivision true
   set endD 60
   ; set proportion .2 ; JO & Ax 111214
   set proportionA .2
   set proportionB .2
   set cryptsizeadjust false; activate if modifying other variables to keep crypt at proper size
   set AdjustTime 1000
   set CellTarget 2428; approx. number of cells in actual crypt, as observed experimentally.
   set AdjustStr .1
   set DivideFbk .5; values set to produce cell proportions most similar to those observed.
   set DieFbk .5
   set QuiescentFbk .1
   set Circadian false ; Ax 112216
   set showgradients false;
   set viewprogeny false;
   ; set CureSound false; Ax 112117
   set CureSound true ; Ax 112217

end

to mutateonecell ; randomly sets a cell in the given row to mutate.
  ; JO & Ax 110514 ; will mutate one cell of A and one cell of B, simultaneously
  ; ifelse count cells with [ycor = top - mutatedepth and mutant = false] > 0[
  ; ask one-of cells with [ycor = top - mutatedepth and mutant = false] [set mutant true]][
  ; print "no elligible cells in the chosen row"]

  ifelse count cells with [ycor = top - mutatedepth and mutantA = false] > 0[
  ask one-of cells with [ycor = top - mutatedepth and mutantA = false] [set mutantA true]][
  print "no elligible cells in the chosen row"]

end

to adjustCptDieMax; method is called by CryptSizeAdjust to attempt to set the size of the crypt to the requested value
  set CptDieMax CptDieMax + (count turtles - Celltarget)/ Celltarget * (AdjustTime - ticks) / (AdjustTime) * AdjustStr
  if CptDieMax < 0 [set CptDieMax 0]
  if CptDieMax > 1 [set CptDieMax 1]
end
@#$#@#$#@
GRAPHICS-WINDOW
118
44
363
487
-1
-1
4.0
1
10
1
1
1
0
1
1
1
-8
45
0
102
1
1
1
ticks
30.0

INPUTBOX
22
363
103
423
SetCellsPerRow
38
1
0
Number

BUTTON
26
124
108
157
NIL
Setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
26
161
107
194
NIL
Go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

INPUTBOX
22
300
101
360
SetTop
100
1
0
Number

PLOT
351
45
518
169
Total Cells
time
CountCells
0.0
10.0
1500.0
3500.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""
"cellspen" 1.0 0 -16777216 true "" ""

INPUTBOX
1299
188
1362
248
CptDivMin
0
1
0
Number

PLOT
352
408
519
528
Quiescent Stem Cells
time
CountCells
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""
"CountQuiescentpen" 1.0 0 -16777216 true "" ""

PLOT
352
288
519
408
Proliferating Cells
time
CountCells
0.0
10.0
600.0
700.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""
"CountProliferatingPen" 1.0 0 -16777216 true "" ""

PLOT
351
167
518
287
Differentiated Cells
time
CountCells
0.0
10.0
1000.0
2000.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""
"CountDifPen" 1.0 0 -16777216 true "" ""

BUTTON
25
198
107
231
NIL
Defaults
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

SLIDER
14
424
108
457
RowsAtStart
RowsAtStart
0
top
61
1
1
NIL
HORIZONTAL

INPUTBOX
987
288
1043
348
Lethality
2
1
0
Number

SLIDER
1278
385
1450
418
QuiesceDepth
QuiesceDepth
0
top
60
1
1
NIL
HORIZONTAL

BUTTON
870
131
991
164
NIL
MutateOneCell
NIL
1
T
OBSERVER
NIL
M
NIL
NIL
1

INPUTBOX
1282
101
1453
161
DiffCellProbabilityThreshold
0.02
1
0
Number

INPUTBOX
869
44
965
104
MutantADivideDiff
0.16
1
0
Number

INPUTBOX
967
44
1060
104
MutantADieDiff
0.1
1
0
Number

INPUTBOX
888
166
970
226
MutateDepth
59
1
0
Number

PLOT
535
43
695
163
Proportion MutantA Cells
time
proprtion
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"propmutsA" 1.0 0 -16777216 true "" ""

TEXTBOX
19
280
139
308
APPLIED BY SETUP
11
0.0
1

TEXTBOX
933
11
1161
53
MUTATES CELL BY ADDING THESE VALUES\n       TO NORMAL CELL PROBABILITES
11
0.0
1

TEXTBOX
892
238
1078
266
APPLIES CHEMOTHERAPY
11
0.0
1

SWITCH
1281
66
1453
99
ShowGradients
ShowGradients
1
1
-1000

TEXTBOX
1310
171
1420
199
CRYPT GRADIENTS
11
0.0
1

MONITOR
707
319
829
364
NIL
MonoclonalTime
17
1
11

MONITOR
707
226
829
271
NIL
ExtinctionTime
17
1
11

MONITOR
707
180
829
225
NIL
UnboundedSizeTime
17
1
11

INPUTBOX
928
289
985
349
Duration
3
1
0
Number

INPUTBOX
877
289
927
349
Interval
24
1
0
Number

BUTTON
1039
130
1132
163
NIL
MutateRowsA
NIL
1
T
OBSERVER
NIL
R
NIL
NIL
1

INPUTBOX
998
166
1048
227
StartD
55
1
0
Number

INPUTBOX
1050
166
1100
226
EndD
60
1
0
Number

INPUTBOX
1104
167
1178
228
ProportionA
0.2
1
0
Number

TEXTBOX
957
113
1126
141
MUTATES ONE OR MORE CELLS
11
0.0
1

INPUTBOX
1299
250
1365
310
CptDivMax
0.5
1
0
Number

INPUTBOX
1299
312
1362
372
CptDivPwr
11.5
1
0
Number

INPUTBOX
1367
188
1431
248
CptDieMin
0
1
0
Number

INPUTBOX
1366
249
1434
309
CptDieMax
0.2
1
0
Number

INPUTBOX
1367
312
1431
372
CptDiePwr
14
1
0
Number

SWITCH
879
253
1042
286
ActiveChemo
ActiveChemo
1
1
-1000

SWITCH
1281
35
1451
68
ViewProgeny
ViewProgeny
1
1
-1000

INPUTBOX
1275
482
1349
542
DivideFbk
0.5
1
0
Number

INPUTBOX
1349
482
1424
542
DieFbk
0.5
1
0
Number

INPUTBOX
915
495
989
555
AdjustTime
1000
1
0
Number

INPUTBOX
988
495
1057
555
CellTarget
2428
1
0
Number

INPUTBOX
1057
495
1126
555
AdjustStr
0.1
1
0
Number

SWITCH
939
462
1095
495
CryptSizeAdjust
CryptSizeAdjust
1
1
-1000

INPUTBOX
1424
482
1505
542
QuiescentFbk
0.1
1
0
Number

SWITCH
953
388
1091
421
PolarDivision
PolarDivision
0
1
-1000

MONITOR
707
273
830
318
NIL
FissionTime
17
1
11

TEXTBOX
1289
464
1587
506
GRADIENT FEEDBACK STRENGTHS\n
11
0.0
1

TEXTBOX
1304
16
1454
34
CRYPT PRESENTATION
11
0.0
1

TEXTBOX
919
360
1159
402
TOGGLES BETWEEN POLAR AND RANDOM\n     CELL DIVISION ORIENTATION
11
0.0
1

TEXTBOX
933
444
1139
472
RESIZES CRYPT USING CptDieMax
11
0.0
1

SLIDER
1278
418
1450
451
DieDepthEnd
DieDepthEnd
0
top
100
1
1
NIL
HORIZONTAL

TEXTBOX
377
22
675
50
PLOTS OF CELLS OR THERAPY AS FUNCTION OF TIME
11
0.0
1

TEXTBOX
725
159
875
177
TIME TO EVENTS
11
0.0
1

TEXTBOX
182
23
332
41
VIRTUAL CRYPT
11
0.0
1

TEXTBOX
33
89
183
117
TO INITIATE\n SIMULATION
11
0.0
1

SWITCH
1053
253
1257
286
ActiveChemoP2
ActiveChemoP2
1
1
-1000

INPUTBOX
1053
288
1116
348
PInterval
24
1
0
Number

INPUTBOX
1117
288
1182
348
PDuration
3
1
0
Number

INPUTBOX
1185
288
1255
348
PTreatment
0.2
1
0
Number

TEXTBOX
1075
239
1260
267
APPLIES CHEMOTHERAPY P2
11
0.0
1

INPUTBOX
1066
44
1168
104
MutantBDivideDiff
0.16
1
0
Number

INPUTBOX
1168
44
1269
105
MutantBDieDiff
0.1
1
0
Number

BUTTON
1135
128
1228
163
MutateRowsB
MutateRowsB
NIL
1
T
OBSERVER
NIL
R
NIL
NIL
1

PLOT
535
162
695
282
Proportion MutantB Cells
time
proportion
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"propmutsB" 1.0 0 -16777216 true "" ""

INPUTBOX
1178
167
1251
227
ProportionB
0.2
1
0
Number

SWITCH
1131
390
1247
423
Circadian
Circadian
1
1
-1000

TEXTBOX
1150
361
1300
395
  CIRCADIAN \nPROLIFERATION
11
0.0
1

PLOT
536
291
696
411
Chemotherapy
NIL
NIL
0.0
10.0
0.0
3.0
true
false
"" ""
PENS
"lethality" 1.0 0 -16777216 true "" ""

PLOT
537
412
697
532
Chemotherapy P2
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"PTreatment" 1.0 0 -16777216 true "" ""

MONITOR
704
370
892
415
TimeToCureToMutantThreshold
timeToCure
17
1
11

INPUTBOX
705
414
892
474
MutantThreshold
0
1
0
Number

SWITCH
1140
493
1251
526
CureSound
CureSound
0
1
-1000

TEXTBOX
1136
459
1263
487
 SOUND ANNOUNCES\nMUTANTS ELIMINATED
11
0.0
1

@#$#@#$#@


## AGENT-BASED COMPUTATIONAL MODEL OF THE COLON CRYPT: DEVELOPMENT OF A VIRTUAL CRYPT FOR IN-SILICO EXPERIMENTS

January 8, 2013
Coded by Rafael Bravo
Info text written by Rafael Bravo and David Axelrod
Department of Genetics, Rutgers University, Piscataway, NJ 08854-8082, USA


Info text revised by David Axelrod
November. 22, 2016, May 16, 2017, November 9, 2017

Code revised by
David Axelrod, James Obaniyi, Sudeepti Vedula, Vadim Dukhovny



## INTRODUCTION:

Colon crypts are invaginations in the large intestine. They are shaped like a test tube with cells arranged along the sides of the test tube. The function of the colon crypts is to produce mucus to lubricate the feces above the crypt in the lumen of the colon, and remove water from the feces. Several different kinds of cells can be recognized, quiescent stem cells at the bottom, proliferating cells (including active stem cells and transient amplifying cells) near the bottom third, and differentiated non-proliferating cells near the top two-thirds of the crypt. Cells produced near the bottom of the crypt move up and are removed at the top of the crypt.

This is an agent-based model in which the crypt has emergent properties resulting from the behavior of a population of individual cells. Cell types are not fixed, rather at each iteration a given cell has a probability of dividing or dying, or dividing and then dying. A cell's probability is determined by its position in a divide gradient and a die gradient. The divide gradient value is greatest at the bottom of the crypt, and the die gradient value is greatest at the top. A cell that divides produces a progeny cell in the same position as the progenitor and a progeny cell that is placed to the right and below the progenitor cell. A cell that dies allows cells below it to move up. These two process result in a flow of cells from the bottom to the top of the crypt, a stochastic variation in the total number of cells per crypt, and in the number of each type of cell.

The goals of this model are (1) to simulate numbers of cell types meaured in biopsies of human crypts, and (2) to facilitate in silico experiments.  These experiments provide information about the effect of mutations that affect probability of cell proliferation, cell death, orientation of cell division, and response to cytotoxic therapy, among others. Parameter values of normal and mutant cells, and their microenvironment gradients, can be input at the Interface without changing the code. Outputs of stochastic cell dynamics are shown as plots and as digital values in the Interface, and can be exported in spreadsheet format for further analysis.


## PROGRAM OVERVIEW:

Three views are available. The "Interface" view has a visual representation of the simulated crypt, buttons and sliders for input, and simulation outputs as plots of cell numbers as a function of time. The "Information" view has the description of the program. The "Procedures" view has the commented code.

The Interface view includes a picture of a crypt with three types of cells: quiescent stem cells at the bottom of the crypt in blue, proliferating cells (active stem cells and transient amplifying cells) in the bottom third of the crypt in red, and differentiated cells at the top two thirds of the crypt in blue; mutant cells, if they exist, are yellow. The lamina propria surrounding the crypt cells is brown. The lumen above the crypt is black.

The initial properties of each cell type and cell environment (gradients of extracellular ligands) are specified with buttons and sliders. Outputs of simulations include a picture of different cell types by color and location, and plots as a function of time of the three cell types.

If a cell divides one of the progeny cells move to the lower right, displacing cells previously in that  position. When cells reach the right edge of the crypt then they wrap around to the left. If a cell dies, cells below it move up. If a cell reaches the top of the crypt it is removed.

## INITIATION

"Setup": initializes the world, the height of the world is determined by "Top", the width by "CellsPerRow", and the size of the initial crypt by "DepthCellsAtStart", these can only be modified before setup.

"Go": button that initiates the simulation. When clicked, all of the functions are implemented for repeated runs. A series of runs can be stopped by pressing the "Go" button again, which pauses the simulation at the conclusion of the most recent run.

"Defaults": sets input parameters to their default values as specified in the code. default values and justifications for these values can be found in the Procedures

##  APPLIED BY SETUP

"SetTop":  height of the world in which the crypt exists.

"SetCellsPerRow" : number of cells across crypt. Width of world is number of cells per row plus 2 on each side.

"RowsAtStart" :  at beginning of simulation, sets number of cells in each column.

## INPUTS:

## MUTATES CELL BY ADDING THESE VALUES TO NORMAL CELL PROBABILITIES

"MutantDivideDiff": the probability of a mutant cell dividing at a given location in the crypt is changed by adding the value of "MutantDivideDiff" to the value of the cell's own pobdivide determined by its position in the divide gradient. This causes a mutant cell to divide with a different probability than normal cells in the same position.

"MutantDieDiff": the probability of a mutant cell dying at a given location in the crypt is changed by adding the value of "MutantDieDiff" to the value of the cell's own pobdie determined by its position in the die gradient. This causes a mutant cell to die with a different probability than normal cells in the same position.

Heterogeneous adenomas can be enabled by mutating both MutantA and MutantB. These appear in different colors.

“MutantADivideDiff” and “MutantADieDiff” determine parameter values of MutantA.

“MutantBDivideDiff” and “MutantBDieDiff” determine parameter values of MutantB.


## MUTATES ONE OR MORE CELLS

"MutateOneCell": button turns one cell from the crypt into a mutant. It appears as a yellow cell, and all of its progeny inherit the mutant trait. Mutant cells are altered by "MutantDivideDiff" and "MutantDieDiff", but are otherwise identical to normal cells.

"MutateDepth": the number of rows from the top that a single cell will be produced.

"MutateRows": button mutates a "Proportion" of cells in rows between "StartD" and "EndD", where D (Depth) is the number of cell rows from the top of the crypt.

"StartD": start of mutation region for "MutateRows", see above.

"EndD": end of mutation region for "MutateRows", see above.

"Proportion": the proportion of cells between "StartD" and "EndD" that will be mutated when the "MutateRows" button is pressed.

## APPLIES CHEMOTHERAPY

"ActiveChemo": toggle "On" begins a dose of cytotoxic therapy.

"Interval": the number of ticks from the beginning of one dose to the beginning of the next dose. The time between doses is "Interval" minus "Duration"

"Duration": the number of ticks during which a dose of chemotherapy is applied.

"Lethality": this constant is multiplied by each cell's own probddivide. The product is the probability that the cell will be killed in a given tick of therapy, and removed.

Example (dose = D, no dose = n):
Duration 1, Interval 3: DnnDnnDnnDnnDnnDnnDnnD
Duration 3, Interval 9: DDDnnnnnnDDDnnnnnnDDD

## APPLIES CHEMOTHERAPY P2

"ActiveChemoP2" : can be used in two different ways, (1) for chemoprevention when used alone, or (2) for combination chemotherapy when used as a second drug, together with "ActiveChemo" as a first drug.

(1) Chemoprevention:

When "ActiveChemoP2" is used alone for chemoprevention, without "ActiveChemo, it acts as a drug that prevents mutants from producing progeny and forming an adenoma. This is accomplished by increasing the probability that mutant, as well as normal cells, will be removed at the top of the crypt. This may be applied intermittently.

When toggle of "ActiveChemoP2" is “On” the value of “CptDieMax” is that in “Ptreatment”.  The new value of “CptDieMax” is active for an interval of “Pinterval” and duration of  “Pduration.” Between the durations of treatment, the value of “CptDieMax” returns to the value in the input box “CptDieMax”

When the toggle is “Off”, the value of “CptDieMax” is constant, and the value in the input box for “CptDieMax

(2) Combination chemotherapy:

When "ActiveChemoP2" is used together with "ActiveChemo" for combination chemotherapy, "ActiveChemoP2" acts as a second drug that prevents mutants from producing progeny and forming an adenoma. This is accomplished by increasing the probability that mutant cells, as well as normal cells, will be removed at the top of the crypt. This may be applied intermittently.

Combination chemotherapy similates the use of two drugs with different mechanisms of action. APPLIES CHEMOTHERAPY simulates a first drug that kills cells proportional to their probdivide, using the input "Lethality". APPLIES CHEMOTHERAPY P2 simulates a second drug that removes cells from the top of the crypt, both mutant cells and normal cells, using the input "Ptreatment".


## TOGGLES BETWEEN POLAR AND RANDOM CELL DIVISION ORIENTATION

"PolarDivision": when toggle is "On", after division one of the progeny cells moves to the right, either 1 or 2 cell positions, and down 1 cell position. This displaces the cell at that location, forcing it to in turn move with the same displacement as the progeny cell. This process continues until there is an empty space for the last displaced cell to occupy. When toggle is "Off", the progeny cell and the cells it displaces move down either diagonally to the left or right 1 cell position, or directly down one cell position.

## CIRCADIAN PROLIFERATION

“Circadian”: enables probability of cell division to oscillate during the 24 hour day.

Toggle “On” multiples “probdiv” by cosine formula derived from observations of rate of proliferation of cells in human crypts as a function of time during the day, Buchi, K.N. et al. Gastroenterology 101:410-415 (1991), figure 1.

Toggle “Off”, the default, multiples “probdiv” by 1.


## RESIZES CRYPT USING CPTDIEMAX

"CryptSizeAdjust": toggle "On" allows the user to request a steady state size for the crypt, and the program will attempt to meet this size by correcting for the crypt being too large or too small. The program accomplishes this by modifying the "CptDieMax" variable to kill off more or fewer cells per tick, eventually resulting in a properly sized crypt. Toggle "Off" disables this feature.

"AdjustTime": the duration during which the crypt size will be adjusted, counting ticks from setup. The longer this period, the more time "CryptSizeAdjust" will have to reach the requested size, and the more likely a correct crypt size will result.

"CellTarget": target cell number per crypt.

"AdjustStr": determines how quickly the "CptDieMax" variable will be adjusted to compensate for the crypt growing too large or small. A higher value will make the crypt less likely to blow up or extinguish during the "AdjustTime", however it may cause the program to overcompensate for small fluctuations in crypt size.

## CRYPT PRESENTATION

"ViewProgeny" : toggle "Off" sets cell color based on type, proliferating cells are colored red, with a lighter shade indicating a higher probability of dividing. Differentiated cells, and quiescent stem cells, which have an extremely low probability of dividing, are colored blue, with a lighter shade cooresponding to a higher probability of dying. Toggle "On" assigns each cell a different random color, this color is inherited by the cell's progeny.

"ShowGradients": toggle "On" displays colored gradients to the left and right of the crypt cells A green divide gradient is displayed on the left and a red die gradient on the right. The quiescent region which is coded as a gradient but whose power is set to 0, making a it a uniform region, is colored dark green, indicating a 0 probability of dividing in this region. Toggle "Off" doesn't display the gradients and allows the program to run faster.

"DiffCellProbabilityThreshold" : cells with a probability of dividing above the threshold value are considered proliferating cells in visuals and plots. Conversely, cells with a probability of dividing below this value are considered differentiated cells or quiescent cells depending on their location.

## CRYPT GRADIENTS


Gradients: divide and die gradients are described by the following function: p = y^n, where 0<=p=<1, 0<=y=<1, p is the probability that a cell will divide or die, y is related to the range of the gradient, y is raised to the n power. y = 0 at top of the gradient, and y = 1 at the bottom of the gradient. Also, y is scaled so that at the bottom of the gradient y = "Min" and at the top it equals "Max".

The left three inputs affect the divide gradient, the the right three inputs affect the die gradient.

"CptDivMin", "CptDieMin": cooresponds to the gradient value at the minimum end of the gradient. The p = y^n function is scaled so that when y is at it's minimum for the gradient, p = Min.

"CptDivMax", "CptDieMax": cooresponds to the gradient value at the maximum end of the gradient. The p = y^n function is scaled so that when y is at it's maximum for the gradient, p = Max.

"CptDivPwr", "CptDiePwr": cooresponds to the n in the p=y^n function,i.e. the "power" to which y is rasied. This value determines how steeply the gradient approaches it's maximum value.

"QuiesceDepth": slider that sets the distance from the top of the crypt to the top of the quiescent region. The quiescent region extends from the "QuiesceDepth" to the bottom of the world.

"DieDepthEnd": slider that sets the end of the die gradient. The die gradient extends from the top of the crypt to "DieDepthEnd".

## GRADIENT FEEDBACK STRENGTHS

"DivideFbk": affects all cells in the crypt above the quiescent region. For a value of 1, at each tick a cell's "ProbDivide" is set to the value at it's height in the divide gradient. For values less than 1, a cell's "ProbDivide" is set to a value determined by both its value at the previous tick and the value of the gradient at the cell's new position in the gradient. This results in a delay in a cell responding to the new gradient value. For a value of 0, the cell is unaffected by the gradient, and retains its previous probdivide.

"DieFbk": affects all cells in the crypt above "DieDepthEnd". similarly to "DivideFbk", a value of 1 sets cell's "ProbDie" to the value of the gradient at the cell's height. For values less than 1, a cell's "ProbDie" is set to a value determined by both its value at the previous tick and the value of the gradient at the cell's new position in the gradient. This results in a delay in a cell responding to the new gradient value.For a value of 0, the cell is unaffected by the gradient, and retains its previous probdie.

"QuiescentFbk": affects all cells in the quiescent region. With a strength of 1, the cells immediately drop to probdivide = 0. With a strength of less than 1, the cell's probdivide will decriment over time, approaching 0. With a strength of 0, the Quiescent region has no effect.

## OUTPUTS:

## PLOTS OF CELLS AS A FUNCTION OF TIME

Graphs as a function of time (ticks, iterations) of each of the following:

"Total Cells": number of all cells in crypt.

"Differentiated Cells": number of cells which have a probability of dividing greater than "DiffCellProbabilityThreshold" and are located above the quiescent region + "CutOffAboveQuiescentRegion" (this variable is set in the Procedures under setup).

"Proliferating Cells": number of cells which have a probability of dividing greater than "DiffCellProbabilityThreshold", but not including quiescent stem cells. This can include cells which are traditionally referred to as active stem cells as well as transient amplifying cells.

"Quiescent Stem Cells": number of cells which have a probability of dividing less than "DiffCellProbabilityThreshold" and are located below the quiescent region + "CutOffAboveQuiescentRegion".

"Proportion of MutantA Cells" : number of mutant A cells divided by total number of cells.

"Proportion of MutantB Cells" : number of mutant B cells divided by total number of cells.

"Chemotherapy" : lethality

"Chemotherapy P2" : Ptreatment which controls CptDieMax

## TIMES TO EVENTS

"UnboundedSizeTime": if the number of cell rows becomes greater than "SetTop", the crypt is considered unbounded. The "UnboundedSizeTime" reporter displays the number of ticks when this occurs.

"ExtinctionTime": if all of the cells die (removed), the crypt is considered extinct. The "ExtinctionTime" reporter displays the number of ticks when this occurs.

"MonoclonalTime": when the "Viewprogeny" toggle is "On" each cell is assigned a different random color, and this color is inherited by the cell's progeny. The "MonoclonalTime" reporter displays the time period between the time that "Viewprogeny" is toggled "On" and the time that all progeny cells in a crypt have the same color, i.e. that monoclonal conversion has occurred.

"FissionTime": the "FissionTime" reporter displays the period of time between when "PolarDivision" is toggled "On" and the time at which least one column occurs with no cells. A column with no cells that separtes two groups of columns with cells is considered to indicate crypt fission.

"TimeToCureToMutantThreshold": time from start of chemotherapy to time that the number of mutants is reduced to "MutantThreshold". "MutantThreshold" defualt = 0 for complete cure,
or more than 0 for chronic cancer.

## PARAMETER SWEEPING EXPERIMENTS:

"Behavior space" is accessed under "Tools". This produces numerical output of simulations. Output can be saved in an .csv format file, useful for export to Excel or statistical programs for descriptive statistics and graphs. It is possible to designate parameters to be changed,  range of parameters, and intervals.  For instance, with two parameters the program will run through the upper and lower limits of each the two parameters, each at designated intervals. The output will include a list of all of the parameter values for the simulation, not just those being swept. For more information see NetLogo User Manual, accessible under "Help".

## CRITERIA FOR SELECTING DEFAULT VALUES:

The first three can only be changed before activating "Setup". Others can be changed after activating "Setup", but the mouse will need to be clicked outside of any input to activate a new value.

Top (100): convenient value for visualization. If larger, then can have larger number of crypt cells, if too large simulation is slower.

CellsPerRow,RowsAtStart (38): starts the simulation with approximately the number of cells per row and column measured in human crypts.

MutantDivideDiff(0.16): an example value that produces a mutant cell with a greater probability of dividing from others at the same location in the divide gradient.

MutantDieDiff (0.1): an example value that produces a mutant cell with a greater probability of dying from others at the same location in the die gradient.

StartD,EndD (55,60): cells mutated between these rows have a high probability of producing viable mutant progeny rather than dying out.

Proportion (0.2): set so that not all cells between start depth (StartD) and end depth (EndD) are mutated.

MutateHeight (59): Starting at this height, compared to other heights, a mutant cell is more likely to produce viable progeny rather than die out.

Interval, Duration, Lethality (24,3,2): given a lethality of 2, these interval and duration values give a minimum collateral damage with a short time to cure.

CellTarget (2428): average total number of cells measured in human crypts

AdjustTime,AdjustStr (1000,0.1): give "CryptSizeAdjust" a sufficient number of ticks and sufficient strength to achieve the target number of cells.

DiffCellProbabilityThreshold (0.02): gives the approximate numbers of differentiated, proliferating, and quiescent cells measured in human crypts.

CptDivMin,CptDivMax,CptDivPwr (0,0.5,11.5): this combination of values causes cell division behavior that simulates the numbers and proportion of each cell type as measured in human crypts.

CptDieMin,CptDieMax,CptDiePwr (0,0.2,14): this combination of values causes cell death behavior near the top of the crypt to simulate cell migration out of the crypt.

QuiesceDepth (60): simulates the measured total number of cells per crypt, also simulates the approximately measured number and proportion of quiescent cells.

DieDepthEnd (100): causes the die gradient to cover the entire crypt depth with SetTop as its default value.

DivdeFbk,DieFbk,QuiescentFbk (0.5,0.5,0.1): these give intermediate rates of delayed response of cells to their gradient position.

## ACKNOWLEDGEMENTS:

The orginal crypt model was produced with the NetLogo v.4.3.3 application, and revised with NetLogo v. 5.3.1. This model runs on NetLogo v.5.3.1. NetLogo is a multi-agent programmable modeling environment. It is authored by Uri Wilensky and developed at The Center for Connected Learning (CCL) and Computer-Based Modeling. NetLogo is an open-source application available at http://ccl.northwestern.edu/netlogo/.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Expt Runs 042120 Chronotherapy D1, I6, L2" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 6    ; 1 day
set Lethality 2   ; expect ~ 35% extinct</setup>
    <go>go
if ticks &gt; 200 and count cells with [MutantA = true] = 0 and Circadian = false
    [set Circadian true]
if ticks &gt; 200 and count cells with [MutantA = true] = 0 [MutateRowsA]
if count cells with [MutantA = true] / count cells &gt;= 0.20 and activechemo = false
    [set activechemo true]</go>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 210 and count cells with [mutantA = true] = 0</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells &gt;= 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 042720 Circadian Prolif Cells Only" repetitions="2" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go
if ticks = 200 and Circadian = false
    [set Circadian true]</go>
    <timeLimit steps="224"/>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 042820 C Chronotherapy D1, I6, L2" repetitions="50" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 6    ; 1 day
set Lethality 2   ;</setup>
    <go>go
if ticks &gt; 200 and count cells with [MutantA = true] = 0 and Circadian = false
    [set Circadian true]
if ticks &gt; 200 and count cells with [MutantA = true] = 0 [MutateRowsA]
if count cells with [MutantA = true] / count cells &gt;= 0.20 and activechemo = false
    [set activechemo true]</go>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 210 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells &gt;= 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 070820 Chronotherapy D1, I42, L5" repetitions="50" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;</setup>
    <go>go
if ticks &gt; 208 and count cells with [MutantA = true] = 0 and Circadian = false
    [set Circadian true]
if ticks &gt; 200 and count cells with [MutantA = true] = 0 [MutateRowsA]
if count cells with [MutantA = true] / count cells &gt;= 0.20 and activechemo = false
    [set activechemo true]</go>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 210 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells &gt;= 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 071020 B Chronotherapy D1, I42, L5" repetitions="100" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;</setup>
    <go>go
if ticks &gt; 200 and count cells with [MutantA = true] = 0 and Circadian = false
    [set Circadian true]
if ticks &gt; 208 and count cells with [MutantA = true] = 0 [MutateRowsA]
if count cells with [MutantA = true] / count cells &gt;= 0.20 and activechemo = false
    [set activechemo true]</go>
    <timeLimit steps="1000"/>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 210 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells &gt;= 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 072120 Chronotherapy D1, I42, L5" repetitions="700" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;</setup>
    <go>go
if ticks = 200 and count cells with [MutantA = true] = 0 [MutateRowsA]
if ticks = 231 and Circadian = false
    [set Circadian true]
if ticks = 231 + random 6 and (count cells with [MutantA = true] / count cells = 0.20) = true
    and activechemo = false
    [set activechemo true]</go>
    <timeLimit steps="450"/>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 200 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells = 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 072820 Chronotherapy D1, I42, L5, Mut200, Circad200, Chemo206 ticks" repetitions="50" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;
set ProportionA 1  ; to get ~20% mutants quickly</setup>
    <go>go
if ticks = 200 and count cells with [MutantA = true] = 0
    [MutateRowsA]
if ticks = 200 and Circadian = false
    [set Circadian true]
if ticks = 206 and activechemo = false
    [set activechemo true]</go>
    <timeLimit steps="450"/>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 200 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>( Count cells with [mutantA = true] / count cells = 0.20 )</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 073120 Chronotherapy D1, I42, L5, PropA1, Circad200, Mut211, Chemo217" repetitions="50" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;
set ProportionA 1 ; to make mutants ~18% 6 steps after MutateRowsA(55-60)</setup>
    <go>go
if ticks = 200 and Circadian = false
    [set Circadian true]
if ticks = 211 and count cells with [MutantA = true] = 0
    [MutateRowsA]
if ticks = 217 and activechemo = false
    [set activechemo true]</go>
    <timeLimit steps="1000"/>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 216 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>Count cells with [mutantA = true] / count cells</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Expt Run 073120 Chronotherapy D1, I42, L5, PropA1, Circad OFF, Mut206, Chemo212" repetitions="50" runMetricsEveryStep="true">
    <setup>setup
set Duration 1    ; 4hr
set Interval 42   ; 1 week
set Lethality 5   ;
set ProportionA 1 ; to make mutants ~18% 6 steps after MutateRowsA(55-60)</setup>
    <go>go
; if ticks = 200 and Circadian = false
   ; [set Circadian true]
if ticks = 206 and count cells with [MutantA = true] = 0
    [MutateRowsA]
if ticks = 212 and activechemo = false
    [set activechemo true]</go>
    <timeLimit steps="1000"/>
    <exitCondition>ExtinctionTime != 0
or UnboundedSizeTime != 0
or ticks &gt; 211 and count cells with [MutantA = true] &lt;= 1</exitCondition>
    <metric>count turtles</metric>
    <metric>Count cells with [MutantA = true]</metric>
    <metric>Count cells with [mutantA = true] / count cells</metric>
    <enumeratedValueSet variable="CptDivMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PInterval">
      <value value="24"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Lethality">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDiePwr">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutateDepth">
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DieDepthEnd">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustStr">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CureSound">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CryptSizeAdjust">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemo">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Circadian">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ShowGradients">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AdjustTime">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantADieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantThreshold">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDieDiff">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EndD">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="RowsAtStart">
      <value value="61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="StartD">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivMax">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetTop">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewProgeny">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Interval">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MutantBDivideDiff">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionB">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActiveChemoP2">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiesceDepth">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PTreatment">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CellTarget">
      <value value="2428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PolarDivision">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMax">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDieMin">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="QuiescentFbk">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CptDivPwr">
      <value value="11.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DivideFbk">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DiffCellProbabilityThreshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ProportionA">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PDuration">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SetCellsPerRow">
      <value value="38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
