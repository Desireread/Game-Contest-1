; Code for poker game

;Code to initialize file
.386
.model flat, stdcall
Include Irvine32.inc


;Macro to randomly assign nunCards amount of cards to a given deck
shuffle MACRO givenDeck, numCards
  LOCAL addCards
  mov ecx, 0
  call Randomize                                  ;Randomly get key of the next address (Pg.164)
  addCards:
    
    mov eax, deckCount                              
    call RandomRange

    mov placeHolder, eax
    imul eax, 3
    mov esi, OFFSET deck                           ;Load the first byte of deck into esi (pg. 118)
    add esi, eax                                   ;Add the index of the random card to eax to get the proper address
    mov ebx, [esi]                                 ;Load the card into ebx
           
    removeCards deck, placeHolder                           ;Remove the card from deck

    

    mov esi, OFFSET givenDeck
    add esi, ecx
    mov [esi], ebx

    lea edx, givenDeck                ;Load beginning address of givenDeck into edx
    mov eax, ecx                      ;Space number of key into eax
    imul eax, 3                       ;Multiply by 3 to account for memory spacing
    add eax, edx                      ;add beginning address to key value to find starting address of next free space in givenDeck
    mov givenDeck[eax], ebx           ;Load the random card into givenDeck

    inc ecx                           ;The number of cards in givenDeck has increased                  
    dec deckCount                     ;The number of cards in deck has decreased
    cmp ecx, numCards                 ;Check if number of cards in givenDeck has reached the number of cards it needs to load
    jl addCards                                 ;Repeat loop if not
    
ENDM

;Macro to delete a card from a deck
removeCards MACRO givenDeck, addr        ;Define the macro
  LOCAL delete, stop
  mov ecx, LENGTHOF givenDeck            ;Assign the length of the given deck to ecx
  mov eax, addr                          ;Assign the starting address to eax
  lea edx, givenDeck
  delete: 
    cmp eax, ecx                         ;Check if the given address is the last element
    je stop                               ;If element is the last one on the deck, jmp to end
    mov ebx, givenDeck[edx+(eax+1)*3]        ;Assign the value of the next element in the givenDeck to ebx
    mov givenDeck[edx+eax*3], ebx            ;Move the next element to the current position
    inc eax                              ;increment eax to the next position
    jmp delete                           ;Jump back to the beginning of the loop
  stop:
    mov givenDeck[edx+eax*3], " "            ;Assign an empty value to the last element
ENDM



.data
; Create list containing cards
deck BYTE "01h0","02h0","03h0","04h0","05h0","06h0",
     BYTE "07h0","08h0","09h0","10h","jh00","qh00","kh00"
     BYTE "0ah0","01d0","02d0","03d0","04d0","05d0","06d0"
     BYTE "07d0","08d0","09d0","10d0","jd00","qd00","kd00"
     BYTE "ad00","01c0","02c0","03c0","04c0","05c0","06c0","07c0"
     BYTE "08c0","09c0","10c0","jc00","qc00","kc00","ac00","01s0"
     BYTE "02s0","03s0","04s0","05s0","06s0","07s0","08s0","09s0"     
     BYTE "10s0","js00","qs00","ks00","as00"
     BYTE "jes0","jes0"
deckCount DWORD 54
playerDeck BYTE 54*3 DUP(?)
; Create list for computer deck
compDeck BYTE 54*3 DUP(?)
;cardSearch BYTE "What number do you want to look for?", 0             ;Prompt for GOFish player
;inputReminder BYTE "Input format: 1-9 for a number; jack = j, queen = q, king = k, ace = a", 0

placeHolder DWORD 0
playerDeckCount DWORD 0
compDeckCount DWORD 0

.code
main PROC
;Add a procedure for "I declare war"
shuffle playerDeck, 26
shuffle compDeck, 26


;Add a procedure for go fish
shuffle playerDeck, 7
shuffle compDeck, 7

;Print deck to the board (macro?)
printDeck playerDeck, 7
;Player types in the number they are looking for
mov edx, inputReminder
call WriteString
call crlf
mov edx, cardSearch
call WriteString



;Computer either hadns over cards or says go fish
  ;Function checks all elements in computer deck and hands over cards or says go fish
  ;After function, the cards the player recieves is displayed
  ;Player can check for a match of 4
    ;if match is found, player point increases

;Compuetr's turn to play
    ;Random number from compDecks size if chose
    ;Computer asks for number/letter
    ;If player has matching cards, those cards will be surrenedered to computer's deck
      ;This transaction will be displayed
    ;Computers deck will be checked for macthes of 4
      ;If match is found, computer point increases

;Add a procedure for blackjack
  ;Extra
;Procedure for checking a value
;checkValue Proc
  
main ENDP
END main
