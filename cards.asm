; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc


;Macro to randomly assign nunCards amount of cards to a given deck
shuffle MACRO givenDeck, numCards
  mov ecx, 0                  ;Count number of cards in player's deck
  mov edx, 52                 ;Count number of cards left in regular deck
  addCards:                    
    call Randomize            ;Get a random card from deck using randomize to get a random number
    mov eax, edx
    call RandomRange
    mov ebx, deck[eax*4]      ;Move random card to ebx
    mov givenDeck[ecx*4], ebx      ;Add random card from deck (in ebx) to position ecx in given deck
    ;Input operation to remove card from deck
    add ecx                   ;increment ecx (number of cards in given deck)
    cmp ecx, numCards         ;Check if givenDeck contains the right about of cards
    jl addCards               ;Jump back to beginning of loop of givenDeck has less than numCards amount of cards
    sub edx                   ;subtract the amount of cards that are in deck
ENDM

;Macro to delete a card from a deck
removeCards MACRO givenDeck, addr        ;Define the macro
  mov ecx, LENGTHOF givenDeck            ;Assign the length of the given deck to ecx
  mov eax, addr                          ;Assign the starting address to eax
  delete: 
    cmp eax, ecx                         ;Check if the given address is the last element
    je end                               ;If element is the last one on the deck, jmp to end
    mov ebx, givenDeck[(eax+1)*4]        ;Assign the value of the next element in the givenDeck to ebx
    mov givenDeck[eax*4], ebx            ;Move the next element to the current position
    add eax                              ;increment eax to the next position
    jmp delete                           ;Jump back to the beginning of the loop
  end:
    mov givenDeck[eax*4], ' '            ;Assign an empty value to the last element
ENDM

.data
; Create list containing cards
deck DWORD '1h', '2h', '3h','4h','5h','6h','7h','8h','9h','10h','jh','qh','kh','ah','1d','2d','3d','4d','5d','6d','7d','8d','9d','10d','jd','qd','kd','ad','1c','2c','3c','4c','5c','6c','7c','8c','9c','10c','jc','qc','kc','ac','1s','2s','3s','4s','5s','6s','7s','8s','9s','10s','js','qs','ks','as'
; Create list for player deck
playerDeck DWORD 10 DUP(?)
; Create list for computer deck
compDeck DWORD 10 DUP(?)




.code
; Randomly assign cards to each deck
call Randomize
mov eax, 52
call RandomRange
; Shuffle and deal

; Create a loop for the game
  ; 

;Add a procedure for go fish

;Add a procedure for "I declare war"

;Add a procedure for blackjack

;Procedure for checking a value
checkValue Proc
