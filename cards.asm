; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc

.data
; Create list containing cards
deck DWORD '1h', '2h', '3h','4h','5h','6h','7h','8h','9h','10h','jh','qh','kh','ah','1d','2d','3d','4d','5d','6d','7d','8d','9d','10d','jd','qd','kd','ad','1c','2c','3c','4c','5c','6c','7c','8c','9c','10c','jc','qc','kc','ac','1s','2s','3s','4s','5s','6s','7s','8s','9s','10s','js','qs','ks','as'
; Create list for player deck
playerDeck DWORD 10 DUP(?)
; Create list for computer deck
compDeck DWORD 10 DUP(?)


.code
; Randomly assign cards to eack deck

; Shuffle and deal

; Create a loop for the game
  ; 
